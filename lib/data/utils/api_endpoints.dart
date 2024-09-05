class ApiEndPoints {
  static final String baseUrl = 'https://doanbanhangbe.onrender.com/api/';
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
