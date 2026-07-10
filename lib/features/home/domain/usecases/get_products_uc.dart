import 'package:either_dart/either.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../../core/network/error/failure.dart';
import '../repository/base_home_repo.dart';

class GetProductsUc extends BaseUseCase<List<ProductModel>, NoParameters> {
  final BaseHomeRepo baseHomeRepo;

  GetProductsUc(this.baseHomeRepo);

  @override
  Future<Either<Failure, List<ProductModel>>> call(
      NoParameters parameters) async {
    return await baseHomeRepo.getProducts(parameters);
  }
}
