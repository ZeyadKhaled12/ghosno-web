import 'package:either_dart/either.dart';
import 'package:ghosno/core/network/error/failure.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/features/home/data/datasource/home_remote_data_source.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';
import 'package:ghosno/features/home/domain/repository/base_home_repo.dart';
import 'package:ghosno/features/home/domain/usecases/add_to_cart_uc.dart';
import 'package:ghosno/features/home/domain/usecases/buy_uc.dart';
import 'package:ghosno/features/home/domain/usecases/send_comment_uc.dart';

import '../../../../core/network/error/exception.dart';

class HomeRepo extends BaseHomeRepo {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;

  HomeRepo(this.baseHomeRemoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(
      NoParameters parameters) async {
    try {
      final result = await baseHomeRemoteDataSource.getProducts(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(
      AddToCartParameters parameters) async {
    try {
      final result = await baseHomeRemoteDataSource.addToCart(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  @override
  Future<Either<Failure, void>> buy(BuyParameters parameters) async {
    try {
      final result = await baseHomeRemoteDataSource.buy(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  @override
  Future<Either<Failure, void>> sendComment(
      SendCommentParameters parameters) async {
    try {
      final result = await baseHomeRemoteDataSource.sendComment(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
