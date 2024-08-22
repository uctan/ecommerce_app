class ApiEndPoints {
  static final String baseUrl = 'http://192.168.1.96:3002/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _ProductEndPoints productEndPoints = _ProductEndPoints();
}

class _AuthEndPoints {
  final String register = 'user/sign-up';
  final String login = 'user/sign-in';
  final String getDetailUser = 'user/get-details';
  final String logoutUser = 'user/log-out';
}

class _ProductEndPoints {
  final String getAllProduct = 'product/get-all';
  final String getProductDetail = 'product/get-details/';
}
