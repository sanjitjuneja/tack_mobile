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
        if (state.value.isNotEmpty && !state.value.contains('.')) {
          emit(state.copyWith(value: '${state.value}.'));
        }
        break;
      case '0':
        if (state.value.isNotEmpty) {
          if (state.value.length < 4 || state.value.contains('.')) {
            emit(state.copyWith(value: '${state.value}0'));
          } else {
            emit(state.copyWith(value: '${state.value}.0'));
          }
        }
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
        if (state.value.length < 4 || state.value.contains('.')) {
          emit(state.copyWith(value: '${state.value}${event.symbol}'));
        } else {
          emit(state.copyWith(value: '${state.value}.${event.symbol}'));
        }
        break;
    }
  }
}
