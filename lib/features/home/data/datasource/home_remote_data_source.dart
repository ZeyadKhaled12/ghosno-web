import 'dart:convert';

import 'package:ghosno/core/local/local_pref.dart';
import 'package:ghosno/features/home/data/models/check_stock_model.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';
import 'package:ghosno/features/home/domain/usecases/add_to_cart_uc.dart';
import 'package:ghosno/features/home/domain/usecases/buy_uc.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/error/error_message_model.dart';
import '../../../../core/network/error/exception.dart';
import '../../../../core/network/error/handle_logic_errors.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../../../core/utils/app_api.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<ProductModel>> getProducts(NoParameters parameters);
  Future<void> addToCart(AddToCartParameters parameters);
  Future<void> buy(BuyParameters parameters);
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts(NoParameters parameters) async {
    return await HandleLogicErrors<List<ProductModel>>(fun: () async {
      final res = await http.get(Uri.parse(AppApi.getProducts), headers: {
        'accept': '*/*',
      });
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 204 ||
          res.statusCode == 205) {
        return (jsonDecode(res.body) as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      }
      throw ServerException(ErrorMessageModel.fromJson(jsonDecode(res.body)));
    }).checkLogicErrors();
  }

  @override
  Future<void> addToCart(AddToCartParameters parameters) async {
    return await HandleLogicErrors<void>(fun: () async {
      final res = await _checkStock(body: parameters.toBody());
      if (res.isAvailable == true) {
        await LocalPref.setCart(parameters.quantity, parameters.product);
        return;
      }
      throw ServerException(
          ErrorMessageModel(statusMessage: res.message ?? ''));
    }).checkLogicErrors();
  }

  Future<CheckStockModel> _checkStock(
      {required Map<String, dynamic> body}) async {
    return await HandleLogicErrors<CheckStockModel>(fun: () async {
      final res = await http.post(Uri.parse(AppApi.checkStock),
          headers: {'accept': '*/*', 'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 204 ||
          res.statusCode == 205) {
        return CheckStockModel.fromJson(jsonDecode(res.body));
      }
      throw ServerException(ErrorMessageModel.fromJson(jsonDecode(res.body)));
    }).checkLogicErrors();
  }

  @override
  Future<void> buy(BuyParameters parameters) async {
    return await HandleLogicErrors<void>(fun: () async {
      final res = await _checkStock(body: parameters.toBody());
      if (res.isAvailable == true) {
        return;
      }
      throw ServerException(
          ErrorMessageModel(statusMessage: res.message ?? ''));
    }).checkLogicErrors();
  }
}
