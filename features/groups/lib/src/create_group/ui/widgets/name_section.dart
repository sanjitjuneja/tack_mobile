import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:groups/src/create_group/bloc/create_group_bloc.dart';

class NameSection extends StatelessWidget {
  final CreateGroupState state;

  const NameSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeaderWidget(
          labelKey: 'createGroupScreen.nameSection.title',
          isRequired: state.nameData.isRequired,
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: 'createGroupScreen.nameSection.placeholder',
          hasShadow: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(
              state.nameData.maxLength,
            ),
          ],
          onTextChange: (String value) => _onNameChange(context, value),
        ),
        const SizedBox(height: 4),
        TextFieldFooter(
          labelKey: 'createGroupScreen.nameSection.footerText',
          content: state.nameData.charactersLeft.toString(),
          maxContent: state.nameData.maxLength.toString(),
        ),
      ],
    );
  }

  void _onNameChange(
    BuildContext context,
    String name,
  ) {
    BlocProvider.of<CreateGroupBloc>(context).add(
      CreateGroupNameChange(name),
    );
  }
}
