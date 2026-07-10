import 'dart:convert';

import 'package:ghosno/core/utils/app_api.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';
import 'package:ghosno/features/checkout/data/models/city_model.dart';
import 'package:ghosno/features/checkout/domain/usecases/calculate_uc.dart';

import '../../../../core/network/error/error_message_model.dart';
import '../../../../core/network/error/exception.dart';
import '../../../../core/network/error/handle_logic_errors.dart';
import '../../../../core/usecase/base_use_case.dart';
import 'package:http/http.dart' as http;

import '../../domain/usecases/create_order_uc.dart';

abstract class BaseCheckoutRemoteDataSource {
  Future<List<CityModel>> getCities(NoParameters parameters);
  Future<CalculateResultModel> calculate(CalculateParameters parameters);
  Future<void> createOrder(CreateOrderParameters parameters);
}

class CheckoutRemoteDataSource extends BaseCheckoutRemoteDataSource {
  @override
  Future<List<CityModel>> getCities(NoParameters parameters) async {
    return await HandleLogicErrors<List<CityModel>>(fun: () async {
      final res = await http.get(Uri.parse(AppApi.getCities), headers: {
        'accept': '*/*',
      });
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 204 ||
          res.statusCode == 205) {
        return (jsonDecode(res.body) as List)
            .map((e) => CityModel.fromJson(e))
            .toList();
      }
      throw ServerException(ErrorMessageModel.fromJson(jsonDecode(res.body)));
    }).checkLogicErrors();
  }

  @override
  Future<CalculateResultModel> calculate(CalculateParameters parameters) async {
    return await HandleLogicErrors<CalculateResultModel>(fun: () async {
      final res = await http.post(Uri.parse(AppApi.calculate),
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(parameters.toBody()));
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 204 ||
          res.statusCode == 205) {
        return CalculateResultModel.fromJson(jsonDecode(res.body));
      }
      throw ServerException(ErrorMessageModel.fromJson(jsonDecode(res.body)));
    }).checkLogicErrors();
  }

  @override
  Future<void> createOrder(CreateOrderParameters parameters) async {
    return await HandleLogicErrors<void>(fun: () async {
      final res = await http.post(Uri.parse(AppApi.createOrder),
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(parameters.createOrderModel.toJson()));
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 204 ||
          res.statusCode == 205) {
        return;
      }
      throw ServerException(ErrorMessageModel.fromJson(jsonDecode(res.body)));
    }).checkLogicErrors();
  }
}
