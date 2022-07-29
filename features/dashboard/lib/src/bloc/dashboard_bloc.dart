import 'dart:math';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/counter_offer_screen/ui/counter_offer_page.dart';
import 'package:dashboard/src/mocked_data/tacks_data.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AppRouterDelegate appRouter;

  DashboardBloc({
    required this.appRouter,
  }) : super(
          DashboardState(
            tacks: tacks,
          ),
        ) {
    on<CounterOfferOpen>(_onCounterOfferOpen);
    on<AcceptTack>(_onAcceptTack);
  }

  Future<void> _onCounterOfferOpen(
    CounterOfferOpen event,
    Emitter<DashboardState> emit,
  ) async {
    final bool? result = await appRouter.pushForResult(
      CounterOffer.page(tack: event.tack),
    );

    if (result != null) {
      _onTackRequestAnswer(result);
    }
  }

  Future<void> _onAcceptTack(
    AcceptTack event,
    Emitter<DashboardState> emit,
  ) async {
    appRouter.push(ProgressDialog.page());
    // API request simulation.
    await Future.delayed(const Duration(seconds: 1));
    appRouter.pop();

    const List<dynamic> answers = <dynamic>['some error', false, true];
    final dynamic answer = answers[Random().nextInt(answers.length)];
    if (answer is String) {
      appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
          ),
        ),
      );
    } else {
      _onTackRequestAnswer(answer);
    }
  }

  Future<void> _onTackRequestAnswer(bool result) async {
    if (result) {
      final bool dialogResult = await appRouter.pushForResult(
        AppAlertDialog.page(
          RequestAlert(
            contentKey: 'otherAlert.offerSent',
          ),
        ),
      );
      if (dialogResult) {
        appRouter.navigationTabState.changeTabIndex(HomeScreenTab.tacks);
      }
    } else {
      appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
            messageKey: 'errors.tackIsNotAvailable',
          ),
        ),
      );
    }
  }
}
