import 'package:either_dart/either.dart';
import 'package:ghosno/core/network/error/failure.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/features/checkout/data/datasource/checkout_remote_data_source.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';
import 'package:ghosno/features/checkout/data/models/city_model.dart';
import 'package:ghosno/features/checkout/domain/repository/base_checkout_repo.dart';
import 'package:ghosno/features/checkout/domain/usecases/calculate_uc.dart';
import 'package:ghosno/features/checkout/domain/usecases/create_order_uc.dart';

import '../../../../core/network/error/exception.dart';

class CheckoutRepo extends BaseCheckoutRepo {
  final BaseCheckoutRemoteDataSource baseCheckoutRemoteDataSource;

  CheckoutRepo(this.baseCheckoutRemoteDataSource);

  @override
  Future<Either<Failure, List<CityModel>>> getCities(
      NoParameters parameters) async {
    try {
      final result = await baseCheckoutRemoteDataSource.getCities(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  @override
  Future<Either<Failure, CalculateResultModel>> calculate(
      CalculateParameters parameters) async {
    try {
      final result = await baseCheckoutRemoteDataSource.calculate(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  @override
  Future<Either<Failure, void>> createOrder(
      CreateOrderParameters parameters) async {
    try {
      final result = await baseCheckoutRemoteDataSource.createOrder(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
