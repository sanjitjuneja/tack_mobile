import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';

part 'offers_event.dart';

part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final FetchTackOffersUseCase _fetchTacksOffersUseCase;

  OffersBloc({
    required Tack tack,
    required FetchTackOffersUseCase fetchTacksOffersUseCase,
  })  : _fetchTacksOffersUseCase = fetchTacksOffersUseCase,
        super(
          OffersState(
            tack: tack,
            isLoading: true,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

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
          offersData: state.offersData.more(
            newPage: offersData,
          ),
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
          offersData: offersData,
        ),
      );
    } catch (e) {
      event.completer.complete(LoadingStatus.failed);
    }
  }
}
