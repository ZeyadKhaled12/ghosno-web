class AppApi {
  static const String baseUrl = 'https://zeyadkhaled.pythonanywhere.com';

  //Home
  static const String getProducts = '$baseUrl/api/v1/products/';
  static const String checkStock = '$baseUrl/api/v1/products/check-stock/';
  static const String sendComment = '$baseUrl/api/v1/contact/';

  //checkout
  static const String getCities = '$baseUrl/api/v1/cities/';
  static const String calculate = '$baseUrl/api/v1/orders/calculate/';
  static const String createOrder = '$baseUrl/api/v1/orders/checkout/';
}
