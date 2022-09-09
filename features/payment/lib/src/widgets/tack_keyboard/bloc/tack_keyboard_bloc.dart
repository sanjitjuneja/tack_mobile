import 'package:core/core.dart';

part 'tack_keyboard_event.dart';

part 'tack_keyboard_state.dart';

class TackKeyboardBloc extends Bloc<TackKeyboardEvent, TackKeyboardState> {
  TackKeyboardBloc() : super(const TackKeyboardState(value: '')) {
    on<KeyboardTapInputEvent>(_onKeyboardTapInputEvent);
    on<KeyboardLongPressInputEvent>(_onKeyboardLongPressInputEvent);
  }

  Future<void> _onKeyboardLongPressInputEvent(
    KeyboardLongPressInputEvent event,
    Emitter<TackKeyboardState> emit,
  ) async {
    if (event.symbol == '<-') {
      emit(state.copyWith(value: ''));
    }
  }

  Future<void> _onKeyboardTapInputEvent(
    KeyboardTapInputEvent event,
    Emitter<TackKeyboardState> emit,
  ) async {
    switch (event.symbol) {
      case '.':
        if (!state.value.contains('.')) {
          emit(state.copyWith(value: '${state.value}.'));
        }
        break;
      case '0':
        if (state.value.isEmpty) break;
        emit(
          state.copyWith(
            value: _addSymbol(event.symbol),
          ),
        );
        break;
      case '<-':
        if (state.value.length == 1 || state.value.isEmpty) {
          emit(state.copyWith(value: ''));
        } else {
          emit(
            state.copyWith(
              value: state.value.substring(0, state.value.length - 1),
            ),
          );
        }
        break;
      default:
        emit(
          state.copyWith(
            value: _addSymbol(event.symbol),
          ),
        );
        break;
    }
  }

  String _addSymbol(String symbol) {
    if (state.value.length == Constants.maxPriceLength) return state.value;

    final bool hasDot = state.value.contains('.');
    final bool reachedLimitBeforePoint =
        state.value.length < Constants.maxDigitsBeforeDot;

    if (reachedLimitBeforePoint || hasDot) {
      return '${state.value}$symbol';
    } else {
      return '${state.value}.$symbol';
    }
  }
}
