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
}
