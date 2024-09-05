class ApiEndPoints {
  static final String baseUrl = 'https://doanbanhangbe.onrender.com/api/';
  // static final String baseUrl = 'http://192.168.1.114:3002/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _ProductEndPoints productEndPoints = _ProductEndPoints();
  static _OrderEndPoints orderEndPoints = _OrderEndPoints();
  static _PaymentEndpPoinrs paymentEndPoints = _PaymentEndpPoinrs();
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

class _OrderEndPoints {
  final String postCreateOrder = 'order/create';
  final String getAllOrder = 'order/get-all-order';
  final String getDetailOrder = 'order/get-details-order/';
  final String deleteOrder = 'order/cancel-order/';
}

class _PaymentEndpPoinrs {
  final String getConfig = 'payment/config';
}
