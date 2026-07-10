import 'package:equatable/equatable.dart';
import 'error_message_model.dart';

abstract class Failure extends Equatable {
  final ErrorMessageModel errorMessageModel;
  const Failure(this.errorMessageModel);

  @override
  List<Object?> get props => [errorMessageModel];
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessageModel);
}

class DataBaseFailure extends Failure {
  const DataBaseFailure(super.errorMessageModel);
}
