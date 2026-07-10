import 'package:either_dart/either.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';
import 'package:ghosno/features/checkout/data/models/city_model.dart';

import '../../../../core/network/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../usecases/calculate_uc.dart';
import '../usecases/create_order_uc.dart';

abstract class BaseCheckoutRepo {
  Future<Either<Failure, List<CityModel>>> getCities(NoParameters parameters);
  Future<Either<Failure, CalculateResultModel>> calculate(
      CalculateParameters parameters);
  Future<Either<Failure, void>> createOrder(CreateOrderParameters parameters);
}
