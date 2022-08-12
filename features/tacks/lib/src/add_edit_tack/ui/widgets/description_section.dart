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
    return AppTextField(
      initialText: state.descriptionData.description,
      placeholder: '${_localizationPath}placeholder',
      isRequired: state.descriptionData.isRequired,
      isInvalid: state.descriptionData.isInvalid,
      errorTextKey: 'validationErrors.fieldRequired',
      minLines: 3,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      hasShadow: false,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      inputFormatters: <TextInputFormatter>[
        WordsLengthFormatter(state.descriptionData.maxWords),
      ],
      onTextChange: (String value) => _onDescriptionChange(context, value),
    );
  }

  void _onDescriptionChange(BuildContext context, String value) {
    BlocProvider.of<AddEditTackBloc>(context).add(DescriptionChange(value));
  }
}
