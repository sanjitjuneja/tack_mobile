import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';

part 'offers_event.dart';

part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final FetchTackOffersUseCase _fetchTacksOffersUseCase;
  final ObserveOfferIntentUseCase _observeOfferIntentUseCase;

  late StreamSubscription<WebSocketIntent<Offer>> _offerIntentSubscription;

  OffersBloc({
    required Tack tack,
    required FetchTackOffersUseCase fetchTacksOffersUseCase,
    required ObserveOfferIntentUseCase observeOfferIntentUseCase,
  })  : _fetchTacksOffersUseCase = fetchTacksOffersUseCase,
        _observeOfferIntentUseCase = observeOfferIntentUseCase,
        super(
          OffersState(
            tack: tack,
            isLoading: true,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<OfferExpiredAction>(_onOfferExpiredAction);
    on<OfferIntentAction>(_onOfferIntentAction);

    _offerIntentSubscription = _observeOfferIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<Offer> offerIntent) {
      add(OfferIntentAction(offerIntent: offerIntent));
    });

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<OffersState> emit,
  ) async {
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<OffersState> emit,
  ) async {
    try {
      final PaginationModel<Offer> offersData =
          await _fetchTacksOffersUseCase.execute(
        FetchTackOffersPayload(tack: state.tack),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          offersData: offersData,
        ),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            offersData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<OffersState> emit,
  ) async {
    try {
      final PaginationModel<Offer> offersData =
          await _fetchTacksOffersUseCase.execute(
        FetchTackOffersPayload(
          tack: state.tack,
          lastObjectId: state.offersData.results.lastOrNull?.id,
          nextPage: state.offersData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          offersData: state.offersData.more(
            newPage: offersData,
          ),
        ),
      );
    } catch (e) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onOfferExpiredAction(
    OfferExpiredAction event,
    Emitter<OffersState> emit,
  ) async {
    emit(
      state.copyWith(
        offersData: state.offersData.removeItem(
          itemId: event.offerId,
        ),
      ),
    );
  }

  Future<void> _onOfferIntentAction(
    OfferIntentAction event,
    Emitter<OffersState> emit,
  ) async {
    final WebSocketIntent<Offer> intent = event.offerIntent;
    final int? offerTackId = intent.object?.tackId;

    if (offerTackId != null && offerTackId != state.tack.id) return;

    final PaginationModel<Offer> offersData;

    switch (intent.action) {
      case WebSocketAction.create:
        offersData = state.offersData.addItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.update:
        offersData = state.offersData.updateItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.delete:
        offersData = state.offersData.removeItem(
          itemId: intent.objectId,
        );
        break;
    }

    emit(
      state.copyWith(offersData: offersData),
    );
  }

  @override
  Future<void> close() async {
    _offerIntentSubscription.cancel();

    return super.close();
  }
}
