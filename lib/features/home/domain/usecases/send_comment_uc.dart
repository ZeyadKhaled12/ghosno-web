import 'package:either_dart/either.dart';

import '../../../../core/network/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repository/base_home_repo.dart';

class SendCommentUc extends BaseUseCase<void, SendCommentParameters> {
  final BaseHomeRepo baseHomeRepo;

  SendCommentUc(this.baseHomeRepo);

  @override
  Future<Either<Failure, void>> call(SendCommentParameters parameters) async {
    return await baseHomeRepo.sendComment(parameters);
  }
}

class SendCommentParameters {
  final String name;
  final String email;
  final String phone;
  final String comment;

  SendCommentParameters(
      {required this.name,
      required this.email,
      required this.phone,
      required this.comment});

  Map<String, dynamic> toBody() =>
      {"name": name, "email": email, "phone": phone, "comment": comment};
}
