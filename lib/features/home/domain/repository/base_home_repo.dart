import 'package:either_dart/either.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../../core/network/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../usecases/add_to_cart_uc.dart';
import '../usecases/buy_uc.dart';

abstract class BaseHomeRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts(
      NoParameters parameters);
  Future<Either<Failure, void>> addToCart(AddToCartParameters parameters);
  Future<Either<Failure, void>> buy(BuyParameters parameters);
}
