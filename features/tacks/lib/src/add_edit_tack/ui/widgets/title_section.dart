import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';

class TitleSection extends StatelessWidget {
  static const String _localizationPath = 'addEditTackScreen.titleSection.';

  final AddEditTackState state;

  const TitleSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      initialText: state.titleData.title,
      placeholder: '${_localizationPath}placeholder',
      isRequired: state.titleData.isRequired,
      isInvalid: state.titleData.isInvalid,
      errorTextKey: 'validationErrors.fieldRequired',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      hasShadow: false,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(
          state.titleData.maxLength,
        ),
      ],
      onTextChange: (String value) => _onTitleChange(context, value),
    );
  }

  void _onTitleChange(BuildContext context, String value) {
    BlocProvider.of<AddEditTackBloc>(context).add(TitleChange(value));
  }
}
