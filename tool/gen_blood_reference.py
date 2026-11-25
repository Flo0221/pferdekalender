#!/usr/bin/env python3
"""Erzeugt assets/blood_reference.json (Referenzwerte + Auswertungsregeln).

Referenzwerte: Laboklin Leistungsverzeichnis Pferd 2025/26, Kap. 14.1
„Referenzwerte Pferd“ (einmalig ausgewertet, liegt nur lokal in der App).
Regeln: eigene Zusammenstellung aus allgemein zugänglicher Fachliteratur;
sie ersetzen keine tierärztliche Beurteilung.
"""
import json, pathlib

P = []  # Parameter
def p(key, name, group, unit, low=None, high=None, aliases=(), category=None,
      strong_low=None, strong_high=None, note=None, seasonal=None, summary="category"):
    P.append({k: v for k, v in dict(
        key=key, name=name, group=group, unit=unit, low=low, high=high,
        aliases=list(aliases), category=category, strongLow=strong_low,
        strongHigh=strong_high, note=note, seasonalHigh=seasonal,
        summary=summary).items() if v is not None and v != []})

# --- Enzyme
p("ast", "AST (GOT)", "enzyme", "U/l", high=568, aliases=["GOT", "Aspartat-Aminotransferase"], category="muskel", strong_high=1500,
  note="Nicht leberspezifisch – immer zusammen mit CK und GLDH beurteilen.")
p("ck", "CK", "enzyme", "U/l", high=452, aliases=["Creatinkinase", "Kreatinkinase"], category="muskel", strong_high=2000)
p("gldh", "GLDH", "enzyme", "U/l", high=13, aliases=["Glutamatdehydrogenase"], category="leber", strong_high=40)
p("ggt", "γ-GT", "enzyme", "U/l", high=44, aliases=["GGT", "Gamma-GT", "gamma-Glutamyltransferase"], category="leber", strong_high=150)
p("ap", "AP", "enzyme", "U/l", high=352, aliases=["Alkalische Phosphatase", "ALP"], category="leber",
  note="Bei jungen Pferden im Wachstum physiologisch höher.")
p("ldh", "LDH", "enzyme", "U/l", high=455, aliases=["Laktatdehydrogenase"], category="muskel")
p("hbdh", "α-HBDH", "enzyme", "U/l", high=221, aliases=["HBDH", "Hydroxybutyrat-Dehydrogenase"], category="muskel")
p("lipase", "Lipase (DGGR)", "enzyme", "U/l", high=20, aliases=["Lipase"], category="stoffwechsel")
# --- Substrate
p("albumin", "Albumin", "substrate", "g/l", 25, 54, category="eiweiss")
p("ag", "A/G-Quotient", "substrate", "", 0.7, 1.1, aliases=["Albumin-Globulin-Quotient"], category="eiweiss")
p("bilirubin", "Bilirubin, total", "substrate", "µmol/l", 8.6, 59.9, aliases=["Bilirubin"], category="leber")
p("cholesterin", "Cholesterin", "substrate", "mmol/l", 1.81, 4.66, aliases=["Cholesterol"], category="stoffwechsel")
p("fructosamin", "Fructosamine", "substrate", "µmol/l", high=360, aliases=["Fruktosamin"], category="stoffwechsel")
p("gallensaeuren", "Gallensäuren", "substrate", "µmol/l", high=12, aliases=["Gallensaeuren"], category="leber", strong_high=25)
p("globuline", "Globuline", "substrate", "g/l", 24, 51, category="entzuendung")
p("glucose", "Glucose", "substrate", "mmol/l", 3.05, 4.99, aliases=["Glukose", "Blutzucker"], category="stoffwechsel")
p("harnstoff", "Harnstoff", "substrate", "mmol/l", 3.3, 6.7, aliases=["Urea"], category="niere")
p("kreatinin", "Kreatinin", "substrate", "µmol/l", 71, 159, aliases=["Creatinin"], category="niere", strong_high=250)
p("lactat", "Lactat", "substrate", "mmol/l", 0.5, 2.0, aliases=["Laktat"], category="stoffwechsel")
p("protein", "Gesamt-Eiweiß", "substrate", "g/l", 55, 75, aliases=["Protein", "Gesamteiweiß", "Gesamtprotein", "TP"], category="eiweiss")
p("saa", "SAA", "substrate", "µg/ml", high=7, aliases=["Serum-Amyloid A", "Amyloid"], category="entzuendung")
p("sdma", "SDMA", "substrate", "µmol/l", high=0.75, category="niere")
p("triglyceride", "Triglyceride", "substrate", "mmol/l", high=0.97, aliases=["Triglyzeride", "Blutfette"], category="stoffwechsel", strong_high=5.0)
# --- Elektrolyte und Spurenelemente
p("calcium", "Calcium", "minerals", "mmol/l", 2.5, 3.4, aliases=["Kalzium", "Ca"], category="mineral", summary="parameter")
p("chlorid", "Chlorid", "minerals", "mmol/l", 95, 105, aliases=["Cl"], category="mineral", summary="parameter")
p("eisen", "Eisen", "minerals", "µmol/l", 17.9, 64.5, aliases=["Fe"], category="mineral", summary="parameter")
p("kalium", "Kalium", "minerals", "mmol/l", 2.8, 4.5, aliases=["K", "Potassium"], category="mineral", summary="parameter")
p("kupfer", "Kupfer", "minerals", "µmol/l", 7.9, 21.0, aliases=["Cu"], category="mineral", summary="parameter")
p("magnesium", "Magnesium", "minerals", "mmol/l", 0.5, 0.9, aliases=["Mg"], category="mineral", summary="parameter")
p("mangan", "Mangan", "minerals", "µg/l", 0.60, 3.50, aliases=["Mn"], category="mineral", summary="parameter")
p("natrium", "Natrium", "minerals", "mmol/l", 125, 150, aliases=["Na", "Sodium"], category="mineral", summary="parameter")
p("phosphat", "Phosphat anorg.", "minerals", "mmol/l", 0.7, 1.5, aliases=["Phosphor", "P"], category="mineral", summary="parameter")
p("selen", "Selen", "minerals", "µg/l", 100, 200, aliases=["Se"], category="mineral", strong_low=70, strong_high=300, summary="parameter",
  note="Laboklin: bis 70 µg/l marginal, über 300 µg/l hoch/kritisch; Fohlen und Islandpferde z. T. deutlich niedriger.")
p("zink", "Zink", "minerals", "µmol/l", 5.0, 14.4, aliases=["Zn"], category="mineral", summary="parameter")
p("vitamin_e", "Vitamin E", "minerals", "mg/l", low=2.0, aliases=["Tocopherol", "Vit. E"], category="mineral", strong_low=1.5, summary="parameter",
  note="Laboklin: > 2 mg/l adäquat, 1,5–2 mg/l marginal, < 1,5 mg/l defizient.")
# --- Hämatologie
p("erythrozyten", "Erythrozyten", "blood", "T/l", 6, 12, aliases=["RBC", "rote Blutkörperchen"], category="blutbild",
  note="Rassenunterschiede: Warmblut 6,5–9, Kaltblut 6–9, Ponys 5,5–8,5, Vollblut 8–12 T/l.")
p("haematokrit", "Hämatokrit", "blood", "l/l", 0.30, 0.50, aliases=["HKT", "Hkt", "Haematokrit"], category="blutbild")
p("haemoglobin", "Hämoglobin", "blood", "g/l", 110, 170, aliases=["Hb", "Haemoglobin"], category="blutbild")
p("leukozyten", "Leukozyten", "blood", "G/l", 5, 10, aliases=["WBC", "weiße Blutkörperchen"], category="entzuendung")
p("thrombozyten", "Thrombozyten", "blood", "G/l", 90, 300, aliases=["Blutplättchen", "PLT"], category="blutbild")
p("neutrophile", "Segmentkernige (absolut)", "blood", "G/l", 3, 7, aliases=["Neutrophile", "Segmentkernige Granulozyten"], category="entzuendung")
p("stabkernige", "Stabkernige (absolut)", "blood", "G/l", 0, 0.6, aliases=["Stabkernige Granulozyten"], category="entzuendung")
p("lymphozyten", "Lymphozyten (absolut)", "blood", "G/l", 1.5, 4, category="entzuendung")
p("monozyten", "Monozyten (absolut)", "blood", "G/l", 0.04, 0.4, category="entzuendung")
p("eosinophile", "Eosinophile (absolut)", "blood", "G/l", 0.04, 0.3, aliases=["Eosinophile Granulozyten"], category="parasiten")
p("basophile", "Basophile (absolut)", "blood", "G/l", 0, 0.15, category="entzuendung")
p("fibrinogen", "Fibrinogen", "blood", "mg/dl", 100, 350, category="entzuendung")
# --- Endokrinologie
p("insulin", "Insulin (basal)", "hormones", "µU/ml", high=15, aliases=["Insulin"], category="stoffwechsel", strong_high=35,
  note="Laboklin: < 15 negativ, 15–35 verdächtig für eine Insulindysregulation, > 35 positiv.")
p("acth", "ACTH (basal)", "hormones", "pg/ml", high=15, aliases=["ACTH"], category="hormone",
  note="Saisonale Grenzwerte nach Equine Endocrinology Group 2023.",
  seasonal=[
    {"months": [12, 1, 2, 3, 4, 5, 6], "high": 15, "strongHigh": 40},
    {"months": [7], "high": 15, "strongHigh": 50},
    {"months": [8], "high": 20, "strongHigh": 75},
    {"months": [9, 10], "high": 30, "strongHigh": 90},
    {"months": [11], "high": 15, "strongHigh": 40},
  ])
p("cortisol", "Cortisol", "hormones", "ng/ml", 30, 70, aliases=["Kortisol"], category="hormone")
p("t4", "T4", "hormones", "µg/dl", 1.3, 4.1, aliases=["Thyroxin"], category="hormone")

GROUPS = [
    {"key": "enzyme", "name": "Enzyme"},
    {"key": "substrate", "name": "Substrate"},
    {"key": "minerals", "name": "Elektrolyte, Spurenelemente, Vitamine"},
    {"key": "blood", "name": "Blutbild (Hämatologie)"},
    {"key": "hormones", "name": "Hormone"},
]
CATEGORIES = {
    "leber": "Leberwerte", "muskel": "Muskelwerte", "niere": "Nierenwerte",
    "eiweiss": "Eiweißwerte", "stoffwechsel": "Stoffwechselwerte",
    "mineral": "Mineralstoffe", "blutbild": "Rotes Blutbild",
    "entzuendung": "Entzündungswerte", "parasiten": "Eosinophile",
    "hormone": "Hormonwerte",
}

# --- Bausteine (ohne Marken)
S = {
 "leber_ergaenzung": dict(kind="supplement", title="Leberunterstützendes Ergänzungsfutter",
   text="Kräutermischung bzw. Ergänzungsfutter zur Leberunterstützung, z. B. mit Mariendistel oder Artischocke. Dosierung laut Packung, Anwendung mit dem Tierarzt abstimmen.",
   item=dict(name="Leber-Ergänzungsfutter (z. B. Mariendistel)", category="ergaenzung", unit="g"), weeks=6),
 "heu_hygiene": dict(kind="management", title="Heu und Weide prüfen",
   text="Heu auf Staub, Schimmel und Giftpflanzen (z. B. Jakobskreuzkraut) prüfen, ggf. Heuanalyse. Weide auf Giftpflanzen absuchen."),
 "zuckerarm": dict(kind="ration", title="Stärke- und zuckerarm füttern",
   text="Getreide/Kraftfutter reduzieren, strukturreiches Heu bevorzugen, Heu bei Bedarf 30–60 min wässern (Mineralstoffe dann ergänzen), Weidegang begrenzen. Umstellung schrittweise."),
 "selen_vite": dict(kind="supplement", title="Selen-/Vitamin-E-Ergänzung",
   text="Nur nach Absprache mit dem Tierarzt – Selen ist überdosiert giftig. Selengehalt im vorhandenen Mineralfutter mitrechnen.",
   item=dict(name="Selen-/Vitamin-E-Ergänzung", category="ergaenzung", unit="g"), weeks=8),
 "vitamin_e": dict(kind="supplement", title="Vitamin-E-Ergänzung",
   text="Vitamin E (bevorzugt natürliches) ergänzen, v. a. in Wintermonaten ohne Weidegang und bei sportlicher Belastung.",
   item=dict(name="Vitamin-E-Ergänzung", category="ergaenzung", unit="g"), weeks=8),
 "mineral_spuren": dict(kind="supplement", title="Mineralfutter mit Spurenelementen",
   text="Bedarfsgerechtes Mineralfutter mit Zink und Kupfer (gern organisch gebunden). Nicht mehrere Mineralfutter kombinieren.",
   item=dict(name="Mineralfutter mit Zink/Kupfer", category="mineralfutter", unit="g"), weeks=12),
 "mineral_ca": dict(kind="supplement", title="Calciumbetontes Mineralfutter",
   text="Mineralfutter mit passendem Calcium-Phosphor-Verhältnis (Ca:P ≈ 1,5–2 : 1); kalziumreiches Raufutter wie Luzerne kann helfen.",
   item=dict(name="Mineralfutter calciumbetont", category="mineralfutter", unit="g"), weeks=12),
 "magnesium": dict(kind="supplement", title="Magnesium-Ergänzung",
   text="Magnesium ergänzen (z. B. Magnesiumoxid oder -citrat laut Packung), auf Rationsgesamtgehalt achten.",
   item=dict(name="Magnesium-Ergänzung", category="ergaenzung", unit="g"), weeks=8),
 "salz": dict(kind="supplement", title="Salz anbieten",
   text="Salzleckstein frei zugänglich bzw. Viehsalz über das Futter, besonders bei Schweiß.",
   item=dict(name="Salz (Viehsalz/Leckstein)", category="mineralfutter", unit="g"), weeks=12),
 "eiweiss": dict(kind="supplement", title="Hochwertiges Eiweiß ergänzen",
   text="Eiweißreiche Komponenten mit guter Aminosäurequalität, z. B. Luzerne, Leinkuchen oder Sojaextraktionsschrot.",
   item=dict(name="Eiweißergänzung (z. B. Luzerne/Leinkuchen)", category="kraftfutter", unit="g"), weeks=8),
 "eiweiss_reduzieren": dict(kind="ration", title="Eiweißüberschuss vermeiden",
   text="Sehr eiweißreiche Futtermittel (z. B. viel Luzerne, Eiweißkonzentrate) reduzieren; ausreichend Wasser."),
 "oel_energie": dict(kind="supplement", title="Öl als Energiequelle",
   text="Energie über Pflanzenöl (z. B. Lein- oder Rapsöl) statt über Stärke; langsam einschleichen.",
   item=dict(name="Pflanzenöl (z. B. Leinöl)", category="oel", unit="ml"), weeks=8),
 "raufutter": dict(kind="ration", title="Fresspausen vermeiden",
   text="Raufutter möglichst ad libitum bzw. mehrmals täglich, keine Fresspausen über 4–6 Stunden; Futteraufnahme beobachten."),
 "wasser": dict(kind="management", title="Wasserversorgung prüfen",
   text="Ständiger Zugang zu sauberem Wasser, Trinkmenge beobachten (auch im Winter: Tränke eisfrei)."),
 "bewegung": dict(kind="management", title="Regelmäßige Bewegung",
   text="Tägliche, moderate Bewegung unterstützt den Stoffwechsel (nur wenn keine Hufrehe besteht)."),
 "belastung_reduzieren": dict(kind="management", title="Belastung vorübergehend reduzieren",
   text="Training anpassen, gut aufwärmen, Stehtage vermeiden; Muskelwerte nach einigen Tagen kontrollieren."),
 "ergaenzung_pruefen": dict(kind="ration", title="Ergänzungen prüfen",
   text="Alle Mineral- und Ergänzungsfutter auf diesen Stoff prüfen und ggf. reduzieren oder absetzen – Überversorgung kann schaden."),
 "kotprobe": dict(kind="care", title="Kotprobe veranlassen",
   text="Parasitenbefall als Ursache abklären (Kotprobe).", careType="builtin_kotprobe", careTitle="Kotprobe (Blutbild)", inDays=7),
 "kontrolle": dict(kind="care", title="Kontroll-Blutbild",
   text="Werte nach einigen Wochen erneut bestimmen lassen.", careType="builtin_tierarzt", careTitle="Kontroll-Blutbild"),
 "tierarzt": dict(kind="care", title="Tierarzt-Termin",
   text="Befund zeitnah mit dem Tierarzt besprechen.", careType="builtin_tierarzt", careTitle="Blutbild besprechen", inDays=3),
}

R = []  # Regeln je Wert und Richtung
def r(param, direction, text, suggestions=(), vet=False, control_weeks=None, vet_if_strong=True):
    R.append({k: v for k, v in dict(param=param, direction=direction, text=text,
        suggestions=list(suggestions), vetFirst=vet, vetIfStrong=vet_if_strong,
        controlWeeks=control_weeks).items() if v is not None})

r("ast", "high", "AST stammt aus Muskel und Leber. Zusammen mit CK spricht es eher für Muskelbelastung, zusammen mit GLDH/γ-GT für die Leber.", ["belastung_reduzieren"], control_weeks=2)
r("ck", "high", "CK zeigt eine frische Muskelbelastung oder -schädigung (z. B. nach Training, Transport, Kreuzverschlag).", ["belastung_reduzieren", "oel_energie", "zuckerarm"], control_weeks=1)
r("ldh", "high", "LDH kommt aus Muskel, Leber und roten Blutkörperchen – Einordnung zusammen mit CK/AST.", ["belastung_reduzieren"], control_weeks=2)
r("hbdh", "high", "α-HBDH stammt v. a. aus Herz- und Skelettmuskel.", vet=True, control_weeks=2)
r("gldh", "high", "GLDH ist leberspezifisch und zeigt eine akute Leberzellbelastung.", ["leber_ergaenzung", "heu_hygiene"], control_weeks=4)
r("ggt", "high", "γ-GT weist auf eine Belastung von Leber bzw. Gallenwegen hin. Laut Laboklin bei geringer Erhöhung Nachtest nach 2–4 Wochen.", ["leber_ergaenzung", "heu_hygiene"], control_weeks=3)
r("ap", "high", "AP stammt aus Leber/Galle und Knochen; bei jungen Pferden normal erhöht.", ["heu_hygiene"], control_weeks=4)
r("gallensaeuren", "high", "Erhöhte Gallensäuren können auf eine eingeschränkte Leberfunktion hinweisen.", ["leber_ergaenzung", "heu_hygiene"], vet=True, control_weeks=4)
r("bilirubin", "high", "Bilirubin steigt beim Pferd schon bei Futterentzug (Fastenhyperbilirubinämie), aber auch bei Leber- oder Bluterkrankungen.", ["raufutter"], control_weeks=2)
r("lipase", "high", "Erhöhte Lipase kann auf die Bauchspeicheldrüse hinweisen.", vet=True)
r("albumin", "low", "Niedriges Albumin: zu wenig Eiweiß im Futter, Eiweißverlust (Darm, Niere, Parasiten) oder Leber.", ["eiweiss", "kotprobe"], control_weeks=6)
r("albumin", "high", "Erhöhtes Albumin deutet meist auf Flüssigkeitsmangel hin.", ["wasser"])
r("ag", "low", "Niedriger A/G-Quotient: meist erhöhte Globuline (Entzündung, Immunreaktion).", vet=True)
r("protein", "low", "Niedriges Gesamteiweiß: Eiweißversorgung, Eiweißverlust oder Parasiten abklären.", ["eiweiss", "kotprobe"], control_weeks=6)
r("protein", "high", "Erhöhtes Gesamteiweiß: Flüssigkeitsmangel oder vermehrte Globuline (Entzündung).", ["wasser"], vet=True)
r("globuline", "high", "Erhöhte Globuline sprechen für Entzündung oder Immunreaktion.", vet=True)
r("harnstoff", "low", "Niedriger Harnstoff kann eine zu knappe Versorgung mit Eiweiß bzw. Aminosäuren widerspiegeln.", ["eiweiss"], control_weeks=8)
r("harnstoff", "high", "Erhöhter Harnstoff: Eiweißüberschuss, Flüssigkeitsmangel oder Niere (zusammen mit Kreatinin beurteilen).", ["eiweiss_reduzieren", "wasser"], control_weeks=4)
r("kreatinin", "high", "Erhöhtes Kreatinin kann auf Flüssigkeitsmangel oder eine eingeschränkte Nierenfunktion hinweisen.", ["wasser"], vet=True, control_weeks=2)
r("kreatinin", "low", "Niedriges Kreatinin passt zu geringer Muskelmasse.", ["eiweiss"])
r("sdma", "high", "SDMA ist ein früher Marker für die Nierenfunktion.", ["wasser"], vet=True)
r("glucose", "high", "Erhöhte Glucose: Stress/Aufregung bei der Blutentnahme oder Stoffwechselstörung (EMS) – mit Insulin abklären.", ["zuckerarm", "bewegung"], control_weeks=6)
r("glucose", "low", "Niedrige Glucose (Probe zu lange gelagert?) oder Energiemangel.", ["raufutter"])
r("fructosamin", "high", "Fructosamine spiegeln den Blutzucker der letzten Wochen – Hinweis auf Stoffwechselstörung.", ["zuckerarm", "bewegung"], control_weeks=8)
r("triglyceride", "high", "Erhöhte Triglyceride: Energiemangel/Fasten (Achtung Ponys, Esel, Minis: Hyperlipämie ist ein Notfall!) oder Stoffwechselstörung.", ["raufutter"], control_weeks=2)
r("cholesterin", "high", "Erhöhtes Cholesterin kommt bei Stoffwechselstörungen vor.", ["zuckerarm", "bewegung"], control_weeks=8)
r("lactat", "high", "Erhöhtes Lactat nach Belastung normal, sonst Hinweis auf Kreislauf-/Kolikgeschehen.", vet=True)
r("insulin", "high", "Erhöhtes basales Insulin weist auf eine Insulindysregulation (EMS) hin – erhöhtes Hufrehe-Risiko.", ["zuckerarm", "bewegung"], control_weeks=8)
r("acth", "high", "Erhöhtes ACTH (saisonal bewertet) weist auf PPID (Equines Cushing) hin.", ["zuckerarm"], vet=True, control_weeks=12)
r("cortisol", "high", "Erhöhtes Cortisol: Stress oder hormonelle Störung.", vet=True)
r("cortisol", "low", "Niedriges Cortisol kann medikamentös bedingt sein.", vet=True)
r("t4", "low", "Niedriges T4 ist beim Pferd oft Folge anderer Erkrankungen oder von Medikamenten – kein Futterthema.", vet=True)
r("t4", "high", "Erhöhtes T4 ist selten.", vet=True)
r("calcium", "low", "Niedriges Calcium: Versorgung bzw. Ca:P-Verhältnis prüfen (viel Kleie/Getreide verschiebt es).", ["mineral_ca"], control_weeks=8)
r("calcium", "high", "Erhöhtes Calcium: Überversorgung oder Nierenthema.", ["ergaenzung_pruefen"], vet=True)
r("phosphat", "high", "Erhöhtes Phosphat: oft viel Getreide/Kleie – Ca:P-Verhältnis prüfen.", ["mineral_ca", "ergaenzung_pruefen"], control_weeks=8)
r("phosphat", "low", "Niedriges Phosphat: Versorgung prüfen.", ["mineral_ca"], control_weeks=8)
r("magnesium", "low", "Niedriges Magnesium: Versorgung prüfen (Nervosität, Muskelzittern möglich).", ["magnesium"], control_weeks=8)
r("magnesium", "high", "Erhöhtes Magnesium: Überversorgung oder Nierenthema.", ["ergaenzung_pruefen"], vet=True)
r("natrium", "low", "Niedriges Natrium: Salzversorgung, starkes Schwitzen oder Durchfall.", ["salz"], control_weeks=4)
r("natrium", "high", "Erhöhtes Natrium: Flüssigkeitsmangel.", ["wasser"], vet=True)
r("chlorid", "low", "Niedriges Chlorid: oft mit Natrium (Schweißverlust).", ["salz"], control_weeks=4)
r("chlorid", "high", "Erhöhtes Chlorid: Flüssigkeitsmangel.", ["wasser"])
r("kalium", "low", "Niedriges Kalium: geringe Futteraufnahme oder Verluste.", ["raufutter"], control_weeks=4)
r("kalium", "high", "Erhöhtes Kalium: häufig Probenfehler (Hämolyse, zu lange gelagert), sonst Niere/Muskel.", vet=True)
r("selen", "low", "Niedriges Selen ist häufig (selenarme Böden/Raufutter) und kann Muskulatur und Immunsystem beeinträchtigen.", ["selen_vite"], control_weeks=12, vet_if_strong=False)
r("selen", "high", "Erhöhtes Selen: Überversorgung durch Ergänzungen – Selen ist in höherer Dosis giftig.", ["ergaenzung_pruefen"], control_weeks=8)
r("vitamin_e", "low", "Vitamin E ist ohne frisches Gras schnell knapp (Winter, Heufütterung, Sport).", ["vitamin_e"], control_weeks=12, vet_if_strong=False)
r("zink", "low", "Niedriges Zink: Versorgung prüfen (Haut, Fell, Hufhorn).", ["mineral_spuren"], control_weeks=12)
r("zink", "high", "Erhöhtes Zink: Überversorgung durch Ergänzungen.", ["ergaenzung_pruefen"])
r("kupfer", "low", "Niedriges Kupfer: Versorgung prüfen (Fellfarbe, Bindegewebe); zu viel Zink/Eisen hemmt die Aufnahme.", ["mineral_spuren"], control_weeks=12)
r("kupfer", "high", "Erhöhtes Kupfer: Überversorgung oder Entzündung.", ["ergaenzung_pruefen"], vet=True)
r("mangan", "low", "Niedriges Mangan: Versorgung prüfen.", ["mineral_spuren"], control_weeks=12)
r("mangan", "high", "Erhöhtes Mangan: Überversorgung durch Ergänzungen.", ["ergaenzung_pruefen"])
r("eisen", "low", "Eisenmangel durch Futter ist beim Pferd selten – meist stecken Blutverlust, Parasiten oder Entzündungen dahinter. Kein Eisen ohne tierärztliche Abklärung.", ["kotprobe"], vet=True)
r("eisen", "high", "Erhöhtes Eisen: Überversorgung (Eisen ist in vielen Futtermitteln reichlich enthalten).", ["ergaenzung_pruefen"], vet=True)
for k in ("erythrozyten", "haemoglobin", "haematokrit"):
    r(k, "low", "Hinweis auf Blutarmut (Anämie) – Ursachen wie Parasiten, Blutverlust oder Entzündungen tierärztlich abklären.", ["kotprobe"], vet=True)
    r(k, "high", "Erhöht meist durch Aufregung/Belastung bei der Blutentnahme oder Flüssigkeitsmangel.", ["wasser"])
r("leukozyten", "high", "Erhöhte Leukozyten: Hinweis auf Entzündung oder Infektion (auch Stress).", vet=True)
r("leukozyten", "low", "Niedrige Leukozyten: z. B. bei Virusinfektionen.", vet=True)
r("neutrophile", "high", "Vermehrte Segmentkernige: Entzündung oder Stress.", vet=True)
r("neutrophile", "low", "Verminderte Segmentkernige: tierärztlich abklären.", vet=True)
r("stabkernige", "high", "Vermehrte Stabkernige: Hinweis auf eine akute Entzündung.", vet=True)
r("lymphozyten", "high", "Vermehrte Lymphozyten: z. B. bei jungen oder aufgeregten Pferden, chronischen Reizen.", vet=True)
r("lymphozyten", "low", "Verminderte Lymphozyten: Stress, Infektion oder Medikamente.", vet=True)
r("monozyten", "high", "Vermehrte Monozyten: eher chronische Entzündung.", vet=True)
r("eosinophile", "high", "Vermehrte Eosinophile: Hinweis auf Parasiten oder Allergie.", ["kotprobe"], control_weeks=6)
r("basophile", "high", "Vermehrte Basophile: Hinweis auf allergisches Geschehen.", vet=True)
r("thrombozyten", "low", "Niedrige Thrombozyten: Gerinnungsneigung beachten – auch Probenfehler (Verklumpung) möglich.", vet=True)
r("thrombozyten", "high", "Erhöhte Thrombozyten: oft bei Entzündungen.", vet=True)
r("fibrinogen", "high", "Erhöhtes Fibrinogen: Entzündungsmarker.", vet=True)
r("saa", "high", "Erhöhtes SAA: empfindlicher Marker für eine akute Entzündung.", vet=True)

COMBOS = [
  dict(id="leber_zelle_galle", all=[["gldh", "high"], ["ggt", "high"]], title="Leber: Zellbelastung und Gallenwege",
       text="GLDH und γ-GT gemeinsam erhöht sprechen für eine Leberbelastung mit Beteiligung der Gallenwege. Bitte zeitnah tierärztlich abklären (u. a. Giftpflanzen, Futterhygiene).",
       vet=True, suggestions=["leber_ergaenzung", "heu_hygiene"], category="leber"),
  dict(id="muskel", all=[["ck", "high"], ["ast", "high"]], none=[["gldh", "high"]], title="Muskel statt Leber",
       text="CK und AST erhöht bei normaler GLDH: Die Erhöhung stammt sehr wahrscheinlich aus der Muskulatur, nicht aus der Leber. Vitamin-E-/Selen-Status mitbeachten.",
       suggestions=["belastung_reduzieren", "oel_energie", "zuckerarm"], category="muskel"),
  dict(id="niere", all=[["harnstoff", "high"], ["kreatinin", "high"]], title="Nierenwerte gemeinsam erhöht",
       text="Harnstoff und Kreatinin gemeinsam erhöht: Flüssigkeitsmangel oder eingeschränkte Nierenfunktion. Bitte tierärztlich abklären.",
       vet=True, suggestions=["wasser"], category="niere"),
  dict(id="ems", all=[["insulin", "high"]], any=[["glucose", "high"], ["triglyceride", "high"], ["fructosamin", "high"]],
       title="Hinweis auf Equines Metabolisches Syndrom",
       text="Erhöhtes Insulin zusammen mit Blutzucker- bzw. Blutfettwerten passt zu EMS. Fütterung und Bewegung anpassen, Hufrehe-Risiko beachten.",
       vet=True, suggestions=["zuckerarm", "bewegung"], category="stoffwechsel"),
  dict(id="selen_vit_e", all=[["selen", "low"], ["vitamin_e", "low"]], title="Selen und Vitamin E niedrig",
       text="Beide Antioxidantien sind knapp – häufig im Winter bzw. bei Heufütterung. Eine kombinierte Ergänzung ist üblich (Selen nur nach Absprache).",
       suggestions=["selen_vite"], category="mineral"),
  dict(id="anaemie_parasiten", any=[["erythrozyten", "low"], ["haemoglobin", "low"], ["haematokrit", "low"]], all=[["eosinophile", "high"]],
       title="Blutarmut und Eosinophile",
       text="Niedrige rote Blutwerte zusammen mit vermehrten Eosinophilen können auf Parasitenbefall hinweisen.",
       vet=True, suggestions=["kotprobe"], category="parasiten"),
]

data = {
  "version": 1,
  "source": "Referenzwerte: Laboklin Leistungsverzeichnis Pferd 2025/26, Kap. 14.1 „Referenzwerte Pferd“ (adulte Pferde). Bei abweichenden Werten auf dem eigenen Befund bitte diese übernehmen.",
  "disclaimer": "Die Auswertung ist ein Hinweis zur Besprechung mit dem Tierarzt – keine Diagnose und keine Therapieempfehlung. Ergänzungen nur nach Absprache füttern.",
  "groups": GROUPS,
  "categories": CATEGORIES,
  "parameters": P,
  "suggestions": S,
  "rules": R,
  "combos": COMBOS,
}
keys = {x["key"] for x in P}
for rule in R:
    assert rule["param"] in keys, rule
    for s in rule["suggestions"]:
        assert s in S, s
for c in COMBOS:
    for cond in c.get("all", []) + c.get("any", []) + c.get("none", []):
        assert cond[0] in keys, cond
    for s in c["suggestions"]:
        assert s in S, s
out = pathlib.Path(__file__).resolve().parent.parent / "assets" / "blood_reference.json"
out.write_text(json.dumps(data, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
print(f"{out}: {len(P)} Parameter, {len(R)} Regeln, {len(COMBOS)} Kombinationen, {len(S)} Bausteine")
