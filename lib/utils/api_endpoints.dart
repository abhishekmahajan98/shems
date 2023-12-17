class ApiEndPoints {
  static const String baseUrl = 'http://localhost:3000/api/';

  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = '/v1/customer/register';
  final String login = '/v1/customer/login';
}
