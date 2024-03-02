class ENV {
  static const String baseUrl = 'http://54.153.163.153/api/v1/';
  static const String imagesBaseUrl = '';

  static const String login = 'customers/login';
  static const String regions = 'regions';
  static String industries({
    required int offset,
    required int limit,
  }) =>
      'industries?offset=$offset&limit=$limit';
  static String search({
    required int id1,
    required int id2,
  }) =>
      'search?industries=$id1,$id2&region=auckland';
}
