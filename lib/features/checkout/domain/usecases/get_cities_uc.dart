import 'package:either_dart/either.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/features/checkout/data/models/city_model.dart';
import 'package:ghosno/features/checkout/domain/repository/base_checkout_repo.dart';

import '../../../../core/network/error/failure.dart';

class GetCitiesUc extends BaseUseCase<List<CityModel>, NoParameters> {
  final BaseCheckoutRepo baseCheckoutRepo;
  GetCitiesUc(this.baseCheckoutRepo);
  @override
  Future<Either<Failure, List<CityModel>>> call(NoParameters parameters) async {
    return await baseCheckoutRepo.getCities(parameters);
  }
}
