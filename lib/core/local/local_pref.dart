import 'dart:convert';

import 'package:ghosno/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/checkout/data/models/create_order_model/create_order_model.dart';

class LocalPref {
  static late SharedPreferences sharedPreferences;

  static Future<void> setCart(int quantity, ProductModel product) async {
    await sharedPreferences.setInt('quantity', quantity);
    await sharedPreferences.setString('product', jsonEncode(product.toJson()));
  }

  static Future<int> getCart() async {
    return sharedPreferences.getInt('quantity') ?? 0;
  }

  static Future<ProductModel> getProduct() async {
    if (sharedPreferences.containsKey('product')) {
      return ProductModel.fromJson(
          jsonDecode(sharedPreferences.getString('product')!));
    }
    return ProductModel();
  }

  static Future<void> setOrderUserDetail(CreateOrderModel createOrder) async {
    await sharedPreferences.setString(
        'create_order', jsonEncode(createOrder.toJson()));
  }

  static CreateOrderModel? getOrderUserDetail() {
    if (sharedPreferences.containsKey('create_order')) {
      String json = sharedPreferences.getString('create_order')!;
      return CreateOrderModel.fromJson(jsonDecode(json));
    }
    return null;
  }
}
