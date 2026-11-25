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
}
