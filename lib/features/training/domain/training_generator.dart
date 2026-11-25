import '../../../core/time/local_date.dart';
import '../../dienstplan/domain/shift_logic.dart';
import 'training.dart';
import 'training_catalog.dart';

/// Eine bereits feststehende Einheit (erledigt, ausgefallen oder fixiert),
/// die der Generator respektiert.
class FixedSession {
  const FixedSession({
    required this.date,
    required this.level,
    this.form,
    this.minutes = 30,
  });
  final LocalDate date;
  final int level;
  final String? form;
  final int minutes;
}

/// Eine vom Generator vorgeschlagene Einheit.
class GeneratedSession {
  const GeneratedSession({
    required this.date,
    required this.unit,
    required this.level,
    required this.minutes,
    required this.content,
    required this.reason,
  });

  final LocalDate date;
  final TrainingUnit unit;
  final int level;
  final int minutes;
  final SessionContent content;
  final SessionReason reason;

  GeneratedSession withUnit(TrainingUnit u, int minutes, SessionContent c) =>
      GeneratedSession(
        date: date,
        unit: u,
        level: u.level,
        minutes: minutes,
        content: c,
        reason: reason,
      );
}

/// Warum ein Tag ohne eigene Einheit bleibt.
enum RestKind { rest, covered, afterNight, noTime, beforeStart }

/// Hinweis, wenn eine Woche nicht wie gewünscht geplant werden konnte.
class WeekWarning {
  const WeekWarning({
    required this.requested,
    required this.achieved,
    required this.nightDays,
    required this.noTimeDays,
    required this.coveredDays,
    required this.shorterPossible,
  });

  final int requested;
  final int achieved;

  /// Tage, die wegen Nachtschicht am Vortag geschont werden.
  final int nightDays;

  /// Tage mit zu wenig Stallzeit.
  final int noTimeDays;

  /// Tage, an denen Beisteller/Reitbeteiligung übernimmt.
  final int coveredDays;

  /// Tage, an denen mit kürzeren Einheiten (≥ 15 min) noch etwas ginge.
  final int shorterPossible;
}

/// Eine Woche des generierten Plans.
class PlannedWeek {
  const PlannedWeek({
    required this.index,
    required this.start,
    required this.sessions,
    required this.load,
    required this.isDeload,
    required this.restDays,
    this.warning,
    this.formRepeatWarning = false,
  });

  /// 0-basiert (Woche 1 = Index 0).
  final int index;
  final LocalDate start;
  final List<GeneratedSession> sessions;

  /// Belastungspunkte inkl. fixierter Einheiten.
  final double load;
  final bool isDeload;
  final Map<LocalDate, RestKind> restDays;
  final WeekWarning? warning;

  /// Zu wenige Trainingsformen gewählt – eine Form kommt öfter als 2× vor.
  final bool formRepeatWarning;
}

class GeneratedPlan {
  const GeneratedPlan(this.weeks);
  final List<PlannedWeek> weeks;

  List<GeneratedSession> get sessions => [for (final w in weeks) ...w.sessions];
}

/// Kleinste sinnvolle Trainingseinheit (Minuten, ohne Puffer).
const minTrainingMinutes = 20;

/// Kleinste Aktivpause (Minuten, ohne Puffer).
const minActivePauseMinutes = 15;

/// Regelbasierter Trainingsplan-Generator (komplett offline, deterministisch).
///
/// Regeln:
/// 1. Nie zwei Tage mit Stufe ≥ 4 hintereinander; nach Stufe 5 folgt
///    Stufe ≤ 2 oder Ruhe.
/// 2. Mindestens 1 Ruhetag pro Woche, wenn möglich zusätzlich 1 Aktivpause.
/// 3. Dieselbe Form höchstens 2× pro Woche (außer Aktivpause); möglichst
///    ≥ 3 verschiedene Formen.
/// 4. Progression je Ziel (siehe [GoalConfig]), Start nach Fitnessstand.
/// 5. Dienstplan: Einheit + Puffer muss in die Stallzeit passen; intensive
///    Einheiten auf Tage mit der meisten Zeit; nach Nachtschicht bzw. ohne
///    Zeit nur Ruhe/Aktivpause; Beisteller-Tage bleiben frei; fehlende
///    Einheiten erzeugen eine [WeekWarning].
/// 6. Fixierte/erledigte Einheiten ([fixed]) bleiben, Tage vor [from] werden
///    nicht neu belegt (Neu-Verteilen).
class TrainingGenerator {
  TrainingGenerator(this.catalog);

  final TrainingCatalog catalog;

  GeneratedPlan generate({
    required TrainingParams params,
    required Map<LocalDate, DayAvailability> availability,
    List<FixedSession> fixed = const [],
    LocalDate? from,
  }) {
    final cfg = catalog.goals[params.goal]!;
    final scaleFitness = catalog.fitnessScale[params.fitness] ?? 1.0;

    // Stufe je Tag (fixiert + bereits geplant) für die Regenerationsregeln.
    final levelByDate = <LocalDate, int>{};
    final fixedByDate = <LocalDate, List<FixedSession>>{};
    for (final f in fixed) {
      (fixedByDate[f.date] ??= []).add(f);
      final prev = levelByDate[f.date] ?? 0;
      if (f.level > prev) levelByDate[f.date] = f.level;
    }

    final weeks = <PlannedWeek>[];
    var unitRotation = 0;
    String? lastForm;

    for (var w = 0; w < params.weeks; w++) {
      final weekStart = params.startDate.addWeeks(w);
      final days = [for (var i = 0; i < 7; i++) weekStart.addDays(i)];
      final deload = cfg.isDeload(w);

      // ---- Wochenparameter
      var scale = scaleFitness * (1 + cfg.progressionPerWeek * w);
      if (deload) scale *= cfg.deloadFactor;
      final levelCap = cfg.levelCap(w);
      final maxMinutes = cfg.maxMinutes(w);
      final noTrot = w < cfg.noTrotWeeks;
      final allowLevel5 =
          !deload &&
          params.fitness >= cfg.level5MinFitness &&
          cfg.level5PerWeek > 0;
      var targetDays = params.daysPerWeek.clamp(1, 6);
      if (cfg.maxDaysPerWeek != null && targetDays > cfg.maxDaysPerWeek!) {
        targetDays = cfg.maxDaysPerWeek!;
      }

      // ---- Tage einordnen
      final info = <LocalDate, _DayInfo>{};
      for (final d in days) {
        final a = availability[d];
        final raw = a?.minutes ?? params.defaultMinutes;
        final minutes = (raw * params.sharePercent / 100).floor();
        info[d] = _DayInfo(
          date: d,
          minutes: minutes,
          usable: minutes - params.bufferMinutes,
          assumed: a?.minutes == null,
          covered: a?.otherPersonCovers ?? false,
          afterNight: a?.afterNightShift ?? false,
          shiftName: a?.template?.name,
          locked: from != null && d.isBefore(from),
          fixed: fixedByDate[d] ?? const [],
        );
      }

      final fixedTraining = [
        for (final d in days)
          for (final f in info[d]!.fixed)
            if (f.level >= 2) f,
      ];
      final formCount = <String, int>{};
      for (final f in [for (final d in days) ...info[d]!.fixed]) {
        if (f.form != null && f.level >= 2) {
          formCount[f.form!] = (formCount[f.form!] ?? 0) + 1;
        }
      }

      bool trainable(_DayInfo i) =>
          !i.locked &&
          i.fixed.isEmpty &&
          !i.covered &&
          !i.afterNight &&
          i.usable >= minTrainingMinutes;

      // ---- Trainingstage wählen: die Tage mit der meisten Zeit
      final need = (targetDays - fixedTraining.length).clamp(0, 7);
      final candidates =
          [
            for (final d in days)
              if (trainable(info[d]!)) info[d]!,
          ]..sort((a, b) {
            final byMin = b.usable.compareTo(a.usable);
            return byMin != 0 ? byMin : a.date.compareTo(b.date);
          });
      final selected = candidates.take(need).toList();

      // ---- Stufen festlegen
      final plannedLevel = <LocalDate, int>{};
      var highSlots = levelCap >= 4
          ? (cfg.highDaysByFitness[params.fitness] ?? 1)
          : 0;
      if (deload && highSlots > 0) highSlots--;
      highSlots -= fixedTraining.where((f) => f.level >= 4).length;

      int levelAt(LocalDate d) => plannedLevel[d] ?? levelByDate[d] ?? 0;
      bool canBeHigh(LocalDate d) =>
          levelAt(d.addDays(-1)) < 4 &&
          levelAt(d.addDays(1)) < 4 &&
          levelAt(d.addDays(-1)) < 5;

      // Intensive Einheiten auf die Tage mit der meisten Zeit.
      final highDays = <LocalDate>[];
      for (final s in selected) {
        if (highSlots <= 0) break;
        if (canBeHigh(s.date)) {
          plannedLevel[s.date] = 4;
          highDays.add(s.date);
          highSlots--;
        }
      }
      // Höchstens eine Stufe-5-Einheit, auf dem längsten intensiven Tag.
      if (allowLevel5 && highDays.isNotEmpty) {
        final fixed5 = fixedTraining.where((f) => f.level >= 5).length;
        if (fixed5 < cfg.level5PerWeek) {
          plannedLevel[highDays.first] = 5;
        }
      }
      // Übrige Tage: Grundstufe je Ziel.
      var alternate = 0;
      for (final s in selected) {
        if (plannedLevel.containsKey(s.date)) continue;
        var base = levelCap >= 3 ? 3 : levelCap;
        if (base < cfg.minLevel) base = cfg.minLevel;
        if (params.goal == TrainingGoal.muskelerhalt) {
          base = alternate.isEven ? 3 : 2;
          alternate++;
        }
        if (base > levelCap) base = levelCap;
        plannedLevel[s.date] = base;
      }
      // Nach Stufe 5: Folgetag höchstens Stufe 2.
      final recovery = <LocalDate>{};
      for (final d in plannedLevel.keys.toList()) {
        // Vortag Stufe 5 (auch aus der Vorwoche oder fixiert)?
        final prev = plannedLevel[d.addDays(-1)] ?? levelByDate[d.addDays(-1)];
        if ((prev ?? 0) >= 5 && plannedLevel[d]! > 2) {
          plannedLevel[d] = 2;
          recovery.add(d);
        }
      }

      // ---- Einheiten auswählen (in Datumsreihenfolge)
      final sessions = <GeneratedSession>[];
      var formRepeat = false;
      final order = selected.map((s) => s.date).toList()..sort();
      for (final d in order) {
        final i = info[d]!;
        final wanted = plannedLevel[d]!;
        var level = wanted;
        _Pick? pick;
        while (level >= 1 && pick == null) {
          pick = _pickUnit(
            level: level,
            params: params,
            cfg: cfg,
            usable: i.usable,
            maxMinutes: maxMinutes,
            noTrot: noTrot,
            formCount: formCount,
            lastForm: lastForm,
            rotation: unitRotation + w,
          );
          if (pick == null) level--;
        }
        if (pick == null) {
          plannedLevel.remove(d);
          continue;
        }
        if (pick.repeat) formRepeat = true;
        plannedLevel[d] = level;
        formCount[pick.unit.form] = (formCount[pick.unit.form] ?? 0) + 1;
        lastForm = pick.unit.form;
        unitRotation++;
        final minutes = _minutes(pick.unit, scale, i.usable, maxMinutes);
        sessions.add(
          GeneratedSession(
            date: d,
            unit: pick.unit,
            level: level,
            minutes: minutes,
            content: _content(pick.unit, level, w, noTrot, cfg, unitRotation),
            reason: SessionReason(
              availableMinutes: i.minutes,
              shiftName: i.shiftName,
              assumedMinutes: i.assumed,
              daysSinceIntensive: _daysSinceIntensive(
                d,
                levelByDate,
                plannedLevel,
              ),
              downgradedFrom: level < wanted ? wanted : null,
              intensive: level >= 4,
              recoveryAfterHigh: recovery.contains(d),
            ),
          ),
        );
      }
      // Tatsächliche Stufen in die Gesamtübersicht übernehmen.
      for (final s in sessions) {
        levelByDate[s.date] = s.level;
      }

      // ---- Aktivpause (wenn ein Ruhetag übrig bleibt)
      final hasActivePause =
          sessions.any((s) => s.level == 1) ||
          [for (final d in days) ...info[d]!.fixed].any((f) => f.level == 1);
      final busy = {
        for (final s in sessions) s.date,
        for (final d in days)
          if (info[d]!.fixed.isNotEmpty) d,
      };
      final inPlan = days.where((d) => !d.isAfter(params.endDate)).toList();
      final freeDays = inPlan.where((d) => !busy.contains(d)).toList();
      if (!hasActivePause && freeDays.length >= 2) {
        // Bevorzugt der Tag nach einer intensiven Einheit, sonst der längste.
        final apCandidates =
            freeDays
                .where(
                  (d) =>
                      !info[d]!.locked &&
                      !info[d]!.covered &&
                      info[d]!.usable >= minActivePauseMinutes,
                )
                .toList()
              ..sort((a, b) {
                final ha = levelAt(a.addDays(-1)) >= 4 ? 1 : 0;
                final hb = levelAt(b.addDays(-1)) >= 4 ? 1 : 0;
                if (ha != hb) return hb.compareTo(ha);
                return info[b]!.usable.compareTo(info[a]!.usable);
              });
        for (final d in apCandidates) {
          final pick = _pickUnit(
            level: 1,
            params: params,
            cfg: cfg,
            usable: info[d]!.usable,
            maxMinutes: maxMinutes,
            noTrot: noTrot,
            formCount: const {},
            lastForm: null,
            rotation: unitRotation + w,
          );
          if (pick == null) continue;
          unitRotation++;
          final i = info[d]!;
          final minutes = _minutes(pick.unit, scale, i.usable, maxMinutes);
          sessions.add(
            GeneratedSession(
              date: d,
              unit: pick.unit,
              level: 1,
              minutes: minutes,
              content: _content(pick.unit, 1, w, true, cfg, unitRotation),
              reason: SessionReason(
                availableMinutes: i.minutes,
                shiftName: i.shiftName,
                assumedMinutes: i.assumed,
                afterNightShift: i.afterNight,
                activePause: true,
                daysSinceIntensive: _daysSinceIntensive(
                  d,
                  levelByDate,
                  plannedLevel,
                ),
              ),
            ),
          );
          levelByDate[d] = 1;
          break;
        }
      }
      sessions.sort((a, b) => a.date.compareTo(b.date));

      // ---- Ruhetage und Warnung
      final sessionDays = {for (final s in sessions) s.date};
      final restDays = <LocalDate, RestKind>{};
      var night = 0, noTime = 0, covered = 0, shorter = 0;
      for (final d in days) {
        final i = info[d]!;
        if (sessionDays.contains(d) || i.fixed.isNotEmpty) continue;
        final kind = i.locked
            ? RestKind.beforeStart
            : i.covered
            ? RestKind.covered
            : i.afterNight
            ? RestKind.afterNight
            : i.usable < minTrainingMinutes
            ? RestKind.noTime
            : RestKind.rest;
        restDays[d] = kind;
        if (kind == RestKind.covered) covered++;
        if (kind == RestKind.afterNight) night++;
        if (kind == RestKind.noTime) {
          noTime++;
          if (i.usable >= minActivePauseMinutes) shorter++;
        }
      }
      final achieved =
          sessions.where((s) => s.level >= 2).length + fixedTraining.length;
      final lockedDays = days.where((d) => info[d]!.locked).length;
      final effectiveTarget = lockedDays == 0
          ? targetDays
          : (targetDays * (7 - lockedDays) / 7).round();
      final load =
          sessions.fold<double>(
            0,
            (sum, s) => sum + catalog.load(s.level, s.minutes),
          ) +
          [
            for (final d in days) ...info[d]!.fixed,
          ].fold<double>(0, (sum, f) => sum + catalog.load(f.level, f.minutes));

      weeks.add(
        PlannedWeek(
          index: w,
          start: weekStart,
          sessions: sessions,
          load: load,
          isDeload: deload,
          restDays: restDays,
          formRepeatWarning: formRepeat,
          warning: achieved < effectiveTarget
              ? WeekWarning(
                  requested: effectiveTarget,
                  achieved: achieved,
                  nightDays: night,
                  noTimeDays: noTime,
                  coveredDays: covered,
                  shorterPossible: shorter,
                )
              : null,
        ),
      );
    }
    return GeneratedPlan(weeks);
  }

  /// Andere passende Einheit derselben Stufe (für „Tauschen“ in der Vorschau).
  GeneratedSession? alternative(
    GeneratedSession s,
    TrainingParams params,
    int weekIndex,
  ) {
    final cfg = catalog.goals[params.goal]!;
    final options = _candidates(
      level: s.level,
      params: params,
      cfg: cfg,
      usable:
          (s.reason.availableMinutes ?? params.defaultMinutes) -
          params.bufferMinutes,
      maxMinutes: cfg.maxMinutes(weekIndex),
      noTrot: weekIndex < cfg.noTrotWeeks,
    );
    if (options.length < 2) return null;
    final idx = options.indexWhere((u) => u.key == s.unit.key);
    final next = options[(idx + 1) % options.length];
    var scale =
        (catalog.fitnessScale[params.fitness] ?? 1.0) *
        (1 + cfg.progressionPerWeek * weekIndex);
    if (cfg.isDeload(weekIndex)) scale *= cfg.deloadFactor;
    final minutes = _minutes(
      next,
      scale,
      (s.reason.availableMinutes ?? params.defaultMinutes) -
          params.bufferMinutes,
      cfg.maxMinutes(weekIndex),
    );
    return s.withUnit(
      next,
      minutes,
      _content(
        next,
        next.level,
        weekIndex,
        weekIndex < cfg.noTrotWeeks,
        cfg,
        idx + 1,
      ),
    );
  }

  List<TrainingUnit> _candidates({
    required int level,
    required TrainingParams params,
    required GoalConfig cfg,
    required int usable,
    required int? maxMinutes,
    required bool noTrot,
  }) => [
    for (final u in catalog.units)
      if (u.level == level &&
          params.forms.contains(u.form) &&
          !u.tags.any(params.exclusions.contains) &&
          !(noTrot && u.tags.contains('trab')) &&
          u.minMinutes <= usable &&
          (maxMinutes == null || u.minMinutes <= maxMinutes))
        u,
  ];

  _Pick? _pickUnit({
    required int level,
    required TrainingParams params,
    required GoalConfig cfg,
    required int usable,
    required int? maxMinutes,
    required bool noTrot,
    required Map<String, int> formCount,
    required String? lastForm,
    required int rotation,
  }) {
    final options = _candidates(
      level: level,
      params: params,
      cfg: cfg,
      usable: usable,
      maxMinutes: maxMinutes,
      noTrot: noTrot,
    );
    if (options.isEmpty) return null;
    // Regel 3: dieselbe Form max. 2× pro Woche (außer Aktivpause).
    final allowed = level == 1
        ? options
        : options.where((u) => (formCount[u.form] ?? 0) < 2).toList();
    final pool = allowed.isEmpty ? options : allowed;

    int score(TrainingUnit u) {
      var s = 0;
      final used = formCount[u.form] ?? 0;
      if (used == 0) s += 100; // neue Form in dieser Woche
      s -= used * 30;
      if (u.form == lastForm) s -= 20; // nicht zweimal hintereinander
      final pref = cfg.preferredForms.indexOf(u.form);
      if (pref >= 0) s += 20 - pref * 3;
      return s;
    }

    final sorted = [...pool]
      ..sort((a, b) {
        final byScore = score(b).compareTo(score(a));
        return byScore != 0 ? byScore : a.key.compareTo(b.key);
      });
    // Unter gleich guten Einheiten abwechseln (Rotation über die Wochen).
    final best = score(sorted.first);
    final top = sorted.where((u) => score(u) == best).toList();
    return _Pick(top[rotation % top.length], allowed.isEmpty);
  }

  int _minutes(TrainingUnit u, double scale, int usable, int? maxMinutes) {
    var m = (u.defaultMinutes * scale / 5).round() * 5;
    var upper = u.maxMinutes;
    if (usable < upper) upper = usable;
    if (maxMinutes != null && maxMinutes < upper) upper = maxMinutes;
    if (m > upper) m = upper;
    if (m < u.minMinutes) m = u.minMinutes;
    return m;
  }

  SessionContent _content(
    TrainingUnit u,
    int level,
    int week,
    bool walkOnly,
    GoalConfig cfg,
    int rotation,
  ) {
    final ex = u.exercises;
    // Intervall-Einheiten: die Intervall-Angabe steht immer oben.
    final fixedFirst = u.interval != null && ex.isNotEmpty;
    final rest = fixedFirst ? ex.sublist(1) : ex;
    final slots = (fixedFirst ? 3 : 4).clamp(0, rest.length);
    final start = rest.isEmpty ? 0 : rotation % rest.length;
    final work = [
      if (fixedFirst) _fillInterval(ex.first, u, week, cfg),
      for (var i = 0; i < slots; i++)
        _fillInterval(rest[(start + i) % rest.length], u, week, cfg),
    ];
    return SessionContent(
      warmup: (walkOnly || level <= 2)
          ? catalog.warmupWalkOnly
          : catalog.warmup,
      work: work,
      cooldown: catalog.cooldown,
      pauseHint: level >= 2 ? catalog.pauseHint : null,
    );
  }

  String _fillInterval(String text, TrainingUnit u, int week, GoalConfig cfg) {
    final spec = u.interval;
    if (spec == null) return text;
    final work = spec.baseWorkMinutes + cfg.intervalGrowthMinutesPerWeek * week;
    return text
        .replaceAll('{work}', formatMinutes(work))
        .replaceAll('{rest}', formatMinutes(spec.restMinutes));
  }

  static int? _daysSinceIntensive(
    LocalDate d,
    Map<LocalDate, int> history,
    Map<LocalDate, int> planned,
  ) {
    for (var back = 1; back <= 14; back++) {
      final p = d.addDays(-back);
      final l = planned[p] ?? history[p] ?? 0;
      if (l >= 4) return back;
    }
    return null;
  }
}

/// 3.0 → „3“, 3.5 → „3,5“ (ohne intl, damit die Domain rein bleibt).
String formatMinutes(double v) {
  final rounded = (v * 2).round() / 2;
  if (rounded == rounded.roundToDouble()) return rounded.toInt().toString();
  return rounded.toString().replaceAll('.', ',');
}

class _DayInfo {
  const _DayInfo({
    required this.date,
    required this.minutes,
    required this.usable,
    required this.assumed,
    required this.covered,
    required this.afterNight,
    required this.shiftName,
    required this.locked,
    required this.fixed,
  });

  final LocalDate date;
  final int minutes;
  final int usable;
  final bool assumed;
  final bool covered;
  final bool afterNight;
  final String? shiftName;
  final bool locked;
  final List<FixedSession> fixed;
}

class _Pick {
  const _Pick(this.unit, this.repeat);
  final TrainingUnit unit;
  final bool repeat;
}
