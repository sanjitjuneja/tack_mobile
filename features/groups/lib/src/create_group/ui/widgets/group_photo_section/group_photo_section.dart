import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:groups/src/create_group/bloc/create_group_bloc.dart';
import 'package:groups/src/create_group/ui/widgets/group_photo_section/group_photo_section_button.dart';
import 'package:groups/src/create_group/ui/widgets/section_header_widget.dart';

class GroupPhotoSection extends StatelessWidget {
  final CreateGroupState state;

  const GroupPhotoSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeaderWidget(
          labelKey: 'createGroupScreen.photoSection.title',
          isRequired: state.groupPhotoData.isRequired,
        ),
        const SizedBox(height: 15),
        if (state.groupPhotoData.hasData) ...<Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: Image.memory(
                    state.groupPhotoData.imageFile!.readAsBytesSync(),
                  ),
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: GroupButtonSectionButton(
                        labelKey: 'createGroupScreen.photoSection.reUploadPhotoButton',
                        icon: AppIconsTheme.camera,
                        onTap: () => _onUploadPhotoPressed(context),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: GroupButtonSectionButton(
                        labelKey: 'createGroupScreen.photoSection.deleteButton',
                        icon: AppIconsTheme.trash,
                        interfaceColor: AppTheme.errorColor,
                        onTap: () => _onDeletePhotoPressed(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
            ],
          )
        ] else ...<Widget>[
          GroupButtonSectionButton(
            labelKey: 'createGroupScreen.photoSection.uploadPhotoButton',
            icon: AppIconsTheme.camera,
            onTap: () => _onUploadPhotoPressed(context),
          ),
        ],
      ],
    );
  }

  void _onUploadPhotoPressed(BuildContext context) {
    BlocProvider.of<CreateGroupBloc>(context).add(
      const CreateGroupPickPhoto(),
    );
  }

  void _onDeletePhotoPressed(BuildContext context) {
    BlocProvider.of<CreateGroupBloc>(context).add(
      const CreateGroupDeletePhoto(),
    );
  }
}
