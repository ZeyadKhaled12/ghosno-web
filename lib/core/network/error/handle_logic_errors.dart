import 'error_message_model.dart';
import 'exception.dart';

class HandleLogicErrors<T> {
  final Future<T> Function() fun;

  HandleLogicErrors({required this.fun});

  Future<T> checkLogicErrors() async {
    try {
      return await fun();
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException(
          ErrorMessageModel(statusMessage: 'OOps there is a proplem happen'));
    }
  }
}
