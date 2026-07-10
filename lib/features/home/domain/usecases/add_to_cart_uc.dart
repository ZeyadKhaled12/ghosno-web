import 'package:either_dart/either.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../../core/network/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repository/base_home_repo.dart';

class AddToCartUc extends BaseUseCase<void, AddToCartParameters> {
  final BaseHomeRepo baseHomeRepo;

  AddToCartUc(this.baseHomeRepo);

  @override
  Future<Either<Failure, void>> call(AddToCartParameters parameters) async {
    return await baseHomeRepo.addToCart(parameters);
  }
}

class AddToCartParameters {
  final ProductModel product;
  final int quantity;

  AddToCartParameters({required this.product, required this.quantity});

  Map<String, dynamic> toBody() =>
      {"product_id": product.id, "quantity": quantity};
}
