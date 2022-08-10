import 'dart:io';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:groups/src/create_group/models/description_data.dart';
import 'package:groups/src/create_group/models/group_photo_data.dart';
import 'package:groups/src/create_group/models/name_data.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/create_group/ui/widgets/image_pick_option_drawer.dart';

part 'create_group_state.dart';

part 'create_group_event.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  // max characters for name.
  static const int _nameMaxLength = 100;

  // max words for description.
  static const int _descriptionMaxWordsLength = 30;

  final AppRouterDelegate _appRouter;
  final CreateGroupUseCase _createGroupUseCase;

  CreateGroupBloc({
    required AppRouterDelegate appRouter,
    required CreateGroupUseCase createGroupUseCase,
  })  : _appRouter = appRouter,
        _createGroupUseCase = createGroupUseCase,
        super(
          const CreateGroupState(
            nameData: NameData(
              maxLength: _nameMaxLength,
              isRequired: true,
            ),
            descriptionData: DescriptionData(
              maxWords: _descriptionMaxWordsLength,
              isRequired: true,
            ),
            groupPhotoData: GroupPhotoData(
              isRequired: true,
            ),
          ),
        ) {
    on<CreateGroupRequest>(_onCreateGroupRequest);
    on<CreateGroupNameChange>(_onCreateGroupNameChange);
    on<CreateGroupDescriptionChange>(_onCreateGroupDescriptionChange);
    on<CreateGroupPickPhoto>(_onCreateGroupPickPhoto);
    on<CreateGroupDeletePhoto>(_onCreateGroupDeletePhoto);
  }

  Future<void> _onCreateGroupRequest(
    CreateGroupRequest event,
    Emitter<CreateGroupState> emit,
  ) async {
    _appRouter.push(ProgressDialog.page());
    try {
      final Group group = await _createGroupUseCase.execute(
        CreateGroupPayload(
          name: state.nameData.name,
          description: state.descriptionData.description,
          image: state.groupPhotoData.imageFile!,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(group);
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.groupCreation',
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onCreateGroupNameChange(
    CreateGroupNameChange event,
    Emitter<CreateGroupState> emit,
  ) async {
    emit(
      state.copyWith(
        name: event.name,
        groupImage: state.groupPhotoData.imageFile,
      ),
    );
  }

  Future<void> _onCreateGroupDescriptionChange(
    CreateGroupDescriptionChange event,
    Emitter<CreateGroupState> emit,
  ) async {
    emit(
      state.copyWith(
        description: event.description,
        groupImage: state.groupPhotoData.imageFile,
      ),
    );
  }

  Future<void> _onCreateGroupPickPhoto(
    CreateGroupPickPhoto event,
    Emitter<CreateGroupState> emit,
  ) async {
    final ImageSource? imageSource = await _appRouter.pushForResult(
      ImagePickOptionDrawer.page(),
    );
    if (imageSource == null) return;

    final XFile? xFile = await FileManager.pickImage(
      imageSource,
      imageQuality: 15,
    );
    if (xFile == null) return;

    final File imageToCrop = await FileManager.writeTempFile(
      await xFile.readAsBytes(),
      fileName: 'imageToCrop',
      mimeType: xFile.mimeType,
    );

    final File? result = await _appRouter.pushForResult(
      ImageCropper.page(file: imageToCrop),
    );

    if (result != null) {
      emit(
        state.copyWith(groupImage: result),
      );
    }
  }

  Future<void> _onCreateGroupDeletePhoto(
    CreateGroupDeletePhoto event,
    Emitter<CreateGroupState> emit,
  ) async {
    emit(
      state.copyWith(groupImage: null),
    );
  }
}
