import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:groups/src/create_group/bloc/create_group_bloc.dart';

class DescriptionSection extends StatelessWidget {
  final CreateGroupState state;

  const DescriptionSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeaderWidget(
          labelKey: 'createGroupScreen.descriptionSection.title',
          isRequired: state.descriptionData.isRequired,
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: 'createGroupScreen.descriptionSection.placeholder',
          keyboardType: TextInputType.text,
          hasShadow: false,
          backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
          minLines: 4,
          inputFormatters: <TextInputFormatter>[
            WordsLengthFormatter(state.descriptionData.maxWords),
          ],
          onTextChange: (String value) => _onDescriptionChange(context, value),
        ),
        const SizedBox(height: 4),
        TextFieldFooter(
          labelKey: 'createGroupScreen.descriptionSection.footerText',
          content: state.descriptionData.wordsLeft.toString(),
          maxContent: state.descriptionData.maxWords.toString(),
        ),
      ],
    );
  }

  void _onDescriptionChange(
    BuildContext context,
    String description,
  ) {
    BlocProvider.of<CreateGroupBloc>(context).add(
      CreateGroupDescriptionChange(description),
    );
  }
}
