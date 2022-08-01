import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';

class DescriptionSection extends StatelessWidget {
  static const String _localizationPath =
      'addEditTackScreen.descriptionSection.';

  final AddEditTackState state;

  const DescriptionSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SectionHeaderWidget(
          labelKey: '${_localizationPath}title',
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: '${_localizationPath}placeholder',
          initialText: state.descriptionData.description,
          minLines: 3,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          hasShadow: false,
          backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
          inputFormatters: <TextInputFormatter>[
            WordsLengthFormatter(state.descriptionData.maxWords),
          ],
          onTextChange: (String value) => _onDescriptionChange(context, value),
        ),
        const SizedBox(height: 4),
        TextFieldFooter(
          labelKey: '${_localizationPath}footerText',
          content: state.descriptionData.wordsLeft.toString(),
          maxContent: state.descriptionData.maxWords.toString(),
        ),
      ],
    );
  }

  void _onDescriptionChange(BuildContext context, String value) {
    BlocProvider.of<AddEditTackBloc>(context).add(DescriptionChange(value));
  }
}
