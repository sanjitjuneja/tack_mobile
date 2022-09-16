import 'dart:async';

import 'package:domain/domain.dart' as domain;

/// Ignore 80 symbols line length in this file for more readability;
///
typedef WebSocketStreamController<T extends Object>= StreamController<domain.WebSocketIntent<T>>;
typedef WebSocketStream<T extends Object> = Stream<domain.WebSocketIntent<T>>;
typedef WebSocketStreamSubscription<T extends Object> = StreamSubscription<domain.WebSocketIntent<T>>;

class WebSocketHandlers {
  /// Controllers
  late WebSocketStreamController<domain.User> userController;
  late WebSocketStreamController<domain.UserBankAccount> userBalanceController;

  late WebSocketStreamController<domain.GroupTack> groupTacksController;
  late WebSocketStreamController<domain.Tack> tacksController;
  late WebSocketStreamController<domain.RunnerTack> runnerTacksController;
  late WebSocketStreamController<domain.Tack> competedTacksRunnerController;
  late WebSocketStreamController<domain.Offer> offersController;

  late WebSocketStreamController<domain.Tack> cancelTackerTacksRunnerController;

  late StreamController<domain.WebSocketIntent<domain.GroupDetails>> groupsController;
  late StreamController<domain.WebSocketIntent<domain.GroupInvitation>> groupInvitationsController;

  /// Stream getters
  WebSocketStream<domain.User> get userStream => userController.stream;
  WebSocketStream<domain.UserBankAccount> get userBalanceStream => userBalanceController.stream;

  WebSocketStream<domain.GroupTack> get groupTacksStream => groupTacksController.stream;
  WebSocketStream<domain.Tack> get tacksStream => tacksController.stream;
  WebSocketStream<domain.RunnerTack> get runnerTacksStream => runnerTacksController.stream;
  WebSocketStream<domain.Tack> get completedTacksRunnerStream => competedTacksRunnerController.stream;
  WebSocketStream<domain.Offer> get offersStream => offersController.stream;

  WebSocketStream<domain.Tack> get cancelTackerTacksRunnerStream => cancelTackerTacksRunnerController.stream;

  WebSocketStream<domain.GroupDetails> get groupsStream => groupsController.stream;
  WebSocketStream<domain.GroupInvitation> get groupInvitationsStream => groupInvitationsController.stream;

  void initStreams() {
    userController = WebSocketStreamController<domain.User>.broadcast();
    userBalanceController = WebSocketStreamController<domain.UserBankAccount>.broadcast();

    groupTacksController = WebSocketStreamController<domain.GroupTack>.broadcast();
    tacksController = WebSocketStreamController<domain.Tack>.broadcast();
    runnerTacksController = WebSocketStreamController<domain.RunnerTack>.broadcast();
    competedTacksRunnerController = WebSocketStreamController<domain.Tack>.broadcast();
    offersController = WebSocketStreamController<domain.Offer>.broadcast();

    cancelTackerTacksRunnerController = WebSocketStreamController<domain.Tack>.broadcast();

    groupsController = WebSocketStreamController<domain.GroupDetails>.broadcast();
    groupInvitationsController =WebSocketStreamController<domain.GroupInvitation>.broadcast();
  }

  void close() {
    userController.close();
    userBalanceController.close();

    groupTacksController.close();
    tacksController.close();
    runnerTacksController.close();
    competedTacksRunnerController.close();
    offersController.close();

    cancelTackerTacksRunnerController.close();

    groupsController.close();
    groupInvitationsController.close();
  }
}
