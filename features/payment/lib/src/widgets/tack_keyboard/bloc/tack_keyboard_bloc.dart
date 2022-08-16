import 'package:core/core.dart';

part 'tack_keyboard_event.dart';

part 'tack_keyboard_state.dart';

class TackKeyboardBloc extends Bloc<TackKeyboardEvent, TackKeyboardState> {
  TackKeyboardBloc() : super(const TackKeyboardState(value: '')) {
    on<KeyboardInputEvent>(_onKeyboardInputEvent);
  }

  Future<void> _onKeyboardInputEvent(
    KeyboardInputEvent event,
    Emitter<TackKeyboardState> emit,
  ) async {
    switch (event.symbol) {
      case '1':
        emit(state.copyWith(value: '${state.value}1'));
        break;
      case '2':
        emit(state.copyWith(value: '${state.value}2'));
        break;
      case '3':
        emit(state.copyWith(value: '${state.value}3'));
        break;
      case '4':
        emit(state.copyWith(value: '${state.value}4'));
        break;
      case '5':
        emit(state.copyWith(value: '${state.value}5'));
        break;
      case '6':
        emit(state.copyWith(value: '${state.value}6'));
        break;
      case '7':
        emit(state.copyWith(value: '${state.value}7'));
        break;
      case '8':
        emit(state.copyWith(value: '${state.value}8'));
        break;
      case '9':
        emit(state.copyWith(value: '${state.value}9'));
        break;
      case '.':
        if (state.value.isNotEmpty && !state.value.contains('.')) {
          emit(state.copyWith(value: '${state.value}.'));
        }
        break;
      case '0':
        emit(state.copyWith(value: '${state.value}0'));
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
    }
  }
}
