import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';

part 'offers_event.dart';

part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final GetTackOffersUseCase _getTackOffersUseCase;

  OffersBloc({
    required Tack tack,
    required GetTackOffersUseCase getTackOffersUseCase,
  })  : _getTackOffersUseCase = getTackOffersUseCase,
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
          await _getTackOffersUseCase.execute(
        TackOffersPayload(tack: state.tack),
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
          await _getTackOffersUseCase.execute(
        TackOffersPayload(
          tack: state.tack,
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
