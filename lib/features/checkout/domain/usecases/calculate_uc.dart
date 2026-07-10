import 'package:either_dart/either.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';

import '../../../../core/network/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repository/base_checkout_repo.dart';

class CalculateUc
    extends BaseUseCase<CalculateResultModel, CalculateParameters> {
  final BaseCheckoutRepo baseCheckoutRepo;
  CalculateUc(this.baseCheckoutRepo);
  @override
  Future<Either<Failure, CalculateResultModel>> call(
      CalculateParameters parameters) async {
    return await baseCheckoutRepo.calculate(parameters);
  }
}

class CalculateParameters {
  final int productID;
  final int cityID;
  final int quantity;
  final String? promoCode;

  CalculateParameters(
      {required this.productID,
      required this.cityID,
      required this.quantity,
      this.promoCode});

  Map<String, dynamic> toBody() {
    final body = {
      "product_id": productID,
      "city_id": cityID,
      "quantity": quantity,
      "promo_code": promoCode
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }
}
