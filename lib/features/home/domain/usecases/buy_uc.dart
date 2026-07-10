import 'package:either_dart/either.dart';

import '../../../../core/network/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../data/models/product_model.dart';
import '../repository/base_home_repo.dart';

class BuyUc extends BaseUseCase<void, BuyParameters> {
  final BaseHomeRepo baseHomeRepo;
  BuyUc(this.baseHomeRepo);
  @override
  Future<Either<Failure, void>> call(BuyParameters parameters) async {
    return await baseHomeRepo.buy(parameters);
  }
}

class BuyParameters {
  final ProductModel product;
  final int quantity;

  BuyParameters({required this.product, required this.quantity});

  Map<String, dynamic> toBody() =>
      {"product_id": product.id, "quantity": quantity};
}
