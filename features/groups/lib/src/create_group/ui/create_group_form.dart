import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/create_group/bloc/create_group_bloc.dart';
import 'package:groups/src/create_group/ui/widgets/description_section.dart';
import 'package:groups/src/create_group/ui/widgets/group_photo_section/group_photo_section.dart';
import 'package:groups/src/create_group/ui/widgets/name_section.dart';

class CreateGroupForm extends StatelessWidget {
  const CreateGroupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupBloc, CreateGroupState>(
      builder: (_, CreateGroupState state) {
        return Column(
          children: <Widget>[
            Expanded(
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        FlutterI18n.translate(
                          context,
                          'createGroupScreen.title',
                        ),
                        style: AppTextTheme.manrope20Medium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        FlutterI18n.translate(
                          context,
                          'createGroupScreen.description',
                        ),
                        style: AppTextTheme.manrope14SemiBold
                            .copyWith(color: AppTheme.textHeavyHintColor),
                      ),
                      const SizedBox(height: 25),
                      NameSection(state: state),
                      const SizedBox(height: 10),
                      DescriptionSection(state: state),
                      const SizedBox(height: 18),
                      GroupPhotoSection(state: state),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 40),
              child: AppCircleButton(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                isDisabled: !state.isReadyToProceed,
                labelKey: 'createGroupScreen.createGroupButton',
                onTap: () => _onCreateGroupPressed(context),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onCreateGroupPressed(
    BuildContext context,
  ) {
    BlocProvider.of<CreateGroupBloc>(context).add(const CreateGroupRequest());
  }
}
