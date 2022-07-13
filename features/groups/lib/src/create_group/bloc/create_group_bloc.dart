import 'dart:io';

import 'package:core/core.dart';
import 'package:core/utils/file_manager.dart';
import 'package:core_ui/core_ui.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/create_group/ui/widgets/image_pick_option_drawer.dart';

part 'create_group_state.dart';
part 'create_group_event.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final AppRouterDelegate appRouter;

  CreateGroupBloc({
    required this.appRouter,
  }) : super(const CreateGroupState()) {
    on<CreateGroupPickPhoto>(_onCreateGroupPickPhoto);
  }

  Future<void> _onCreateGroupPickPhoto(
    CreateGroupPickPhoto event,
    Emitter<CreateGroupState> emit,
  ) async {
    final ImageSource? imageSource = await appRouter.pushForResult(
      ImagePickOptionDrawer.page(),
    );
    if (imageSource == null) return;

    final XFile? xFile = await FileManager.pickImage(imageSource);
    if (xFile == null) return;

    final File imageToCrop = await FileManager.writeTempFile(
      await xFile.readAsBytes(),
      fileName: 'imageToCrop',
      mimeType: xFile.mimeType,
    );

    final File? result = await appRouter.pushForResult(
      ImageCropper.page(file: imageToCrop),
    );

    if (result != null) {
      emit(
        state.copyWith(groupPhoto: result),
      );
    }
  }
}
