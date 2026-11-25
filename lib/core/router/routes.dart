/// Alle Pfade der App an einer Stelle.
abstract final class Routes {
  static const pflege = '/pflege';
  static const training = '/training';
  static const futter = '/futter';
  static const dienst = '/dienst';
  static const pferd = '/pferd';
  static const settings = '/einstellungen';
  static const horseList = '/pferde';
  static const horseNew = '/pferde/neu';
  static String horseEdit(String id) => '/pferde/$id/bearbeiten';
  static const careNewBase = '/pflege-eintrag/neu';
  static String careNew({String? date}) =>
      date == null ? careNewBase : '$careNewBase?datum=$date';
  static String careEdit(String id) => '/pflege-eintrag/$id';
  static const careTypes = '/einstellungen/eintragsarten';
  static const careIntervals = '/einstellungen/intervalle';
  static const shiftTemplates = '/dienst-vorlagen';
  static const shiftPatterns = '/dienst-rhythmen';
  static const shiftPatternNew = '/dienst-rhythmen/neu';
  static String shiftPatternEdit(String id) => '/dienst-rhythmen/$id';
  static const trainingNewBase = '/training-einheit/neu';
  static String trainingNew({String? date}) =>
      date == null ? trainingNewBase : '$trainingNewBase?datum=$date';
  static String trainingEdit(String id) => '/training-einheit/$id';
  static const trainingGenerator = '/training-generator';
  static const trainingPreview = '/training-generator/vorschau';
  static const feedItems = '/futtermittel';
  static const feedVersions = '/futterplan-versionen';
  static const feedSupplements = '/futter-zusaetze';
  static const feedPlanNew = '/futterplan/neu';
  static String feedPlanEdit(String id) => '/futterplan/$id';
  static const health = '/gesundheit';
  static const bloodNew = '/gesundheit/neu';
  static String bloodDetail(String id) => '/gesundheit/$id';
  static String bloodEdit(String id) => '/gesundheit/$id/bearbeiten';
}
