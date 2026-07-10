import 'package:either_dart/either.dart';
import '../../../../core/network/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../data/models/create_order_model/create_order_model.dart';
import '../repository/base_checkout_repo.dart';

class CreateOrderUc extends BaseUseCase<void, CreateOrderParameters> {
  final BaseCheckoutRepo baseCheckoutRepo;
  CreateOrderUc(this.baseCheckoutRepo);
  @override
  Future<Either<Failure, void>> call(CreateOrderParameters parameters) async {
    return await baseCheckoutRepo.createOrder(parameters);
  }
}

class CreateOrderParameters {
  final CreateOrderModel createOrderModel;
  CreateOrderParameters({required this.createOrderModel});
}
