import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../format/formatters.dart';
import '../time/local_date.dart';

/// Eingabefeld für ein optionales Datum mit deutschem Datumswähler.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.clearable = true,
  });

  final String label;
  final LocalDate? value;
  final ValueChanged<LocalDate?> onChanged;
  final LocalDate? firstDate;
  final LocalDate? lastDate;
  final bool clearable;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: () => _pick(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.event_outlined),
          suffixIcon: (clearable && value != null)
              ? IconButton(
                  tooltip: l10n.dateClear,
                  icon: const Icon(Icons.clear),
                  onPressed: () => onChanged(null),
                )
              : null,
        ),
        isEmpty: value == null,
        child: value == null ? null : Text(Fmt.date(value!)),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final today = LocalDate.today();
    final picked = await showDatePicker(
      context: context,
      helpText: label,
      initialDate: (value ?? today).toLocalDateTime(),
      firstDate: (firstDate ?? LocalDate(1980, 1, 1)).toLocalDateTime(),
      lastDate: (lastDate ?? today.addYears(10)).toLocalDateTime(),
    );
    if (picked != null) onChanged(LocalDate.fromDateTime(picked));
  }
}
