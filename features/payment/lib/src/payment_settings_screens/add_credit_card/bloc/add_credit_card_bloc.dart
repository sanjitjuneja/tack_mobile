import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'add_credit_card_event.dart';

part 'add_credit_card_state.dart';

class AddCreditCardBloc extends Bloc<AddCreditCardEvent, AddCreditCardState> {
  final AppRouterDelegate _appRouter;

  AddCreditCardBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const AddCreditCardState());
}
