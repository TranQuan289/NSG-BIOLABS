class BaseURL {
  const BaseURL._({
    required this.schemes,
    required this.host,
    required this.basePath,
  });

  final String schemes;
  final String host;
  final String basePath;
  String get url => schemes + host + basePath;
}

class BaseURLs {
  BaseURLs._();

  static const development = BaseURL._(
    schemes: 'https://nsg-bio.vinova.sg',
    host: '',
    basePath: '/api/v1.0.0',
  );

  static const production = BaseURL._(
    schemes: 'https://nsg-bio.vinova.sg',
    host: '',
    basePath: '/api/v1.0.0',
  );
}
