import 'package:core/core.dart';

abstract class UseCase<OutputT, InputT> {
  OutputT execute(InputT params);
}

abstract class FutureUseCase<OutputT, InputT> {
  Future<OutputT> execute(InputT params);
}

abstract class StreamUseCase<OutputT, InputT> {
  Stream<OutputT> execute(InputT params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => <Object>[];
}
