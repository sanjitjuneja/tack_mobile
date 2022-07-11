import 'dart:math';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/counter_offer_screen/ui/counter_offer_page.dart';
import 'package:dashboard/src/mocked_data/tacks_data.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AppRouterDelegate appRouter;

  DashboardBloc({
    required this.appRouter,
    required List<Group> groups,
  }) : super(
          DashboardState(
            groups: groups,
            currentGroup: groups.first,
            tacks: tacks,
          ),
        ) {
    on<ChangeGroup>(_onChangeGroup);
    on<CounterOfferOpen>(_onCounterOfferOpen);
    on<AcceptTack>(_onAcceptTack);
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<DashboardState> emit,
  ) async {
    final Group? newGroup = await appRouter.pushForResult(
      ChangeGroupDrawer.page(
        state.groups,
        state.currentGroup,
      ),
    );

    emit(
      state.copyWith(currentGroup: newGroup ?? state.currentGroup),
    );
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
      appRouter.push(
        AppAlertDialog.page(
          DestructiveAlert(
            contentKey: 'test',
            title: 'Offer Not Sent',
            message: 'Sorry, smth went wrong, try again.',
            buttonLabel: 'Close',
          ),
        ),
      );
    } else {
      _onTackRequestAnswer(answer);
    }
  }

  void _onTackRequestAnswer(bool result) {
    if (result) {
      appRouter.push(
        AppAlertDialog.page(
          RequestAlert(
            contentKey: 'test',
            title: 'Offer Sent',
            message: 'We will notify you if the offer is accepted',
            buttonLabel: 'View All Offers Sent',
          ),
          onButtonTap: () {},
        ),
      );
    } else {
      appRouter.push(
        AppAlertDialog.page(
          DestructiveAlert(
            contentKey: 'test',
            title: 'Offer Not Sent',
            message: 'Sorry, this Tack is no longer available',
            buttonLabel: 'Close',
          ),
        ),
      );
    }
  }
}
