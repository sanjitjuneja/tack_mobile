import 'package:core/core.dart';
import 'package:customer_support/customer_support.dart';
import 'package:navigation/navigation.dart';

part 'tack_options_event.dart';

part 'tack_options_state.dart';

class TackOptionsBloc extends Bloc<TackOptionsEvent, TackOptionsState> {
  final AppRouterDelegate _appRouter;

  TackOptionsBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const TackOptionsState()) {
    on<OpenCustomerSupport>(_onOpenCustomerSupport);
  }

  Future<void> _onOpenCustomerSupport(
    OpenCustomerSupport event,
    Emitter<TackOptionsState> emit,
  ) async {
    _appRouter.replace(CustomerSupportFeature.page());
  }
}
