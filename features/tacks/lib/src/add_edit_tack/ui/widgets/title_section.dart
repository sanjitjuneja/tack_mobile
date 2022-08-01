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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SectionHeaderWidget(
          labelKey: '${_localizationPath}title',
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: '${_localizationPath}placeholder',
          initialText: state.titleData.title,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          hasShadow: false,
          backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(
              state.titleData.maxLength,
            ),
          ],
          onTextChange: (String value) => _onTitleChange(context, value),
        ),
        const SizedBox(height: 4),
        TextFieldFooter(
          labelKey: '${_localizationPath}footerText',
          content: state.titleData.charactersLeft.toString(),
          maxContent: state.titleData.maxLength.toString(),
        ),
      ],
    );
  }

  void _onTitleChange(BuildContext context, String value) {
    BlocProvider.of<AddEditTackBloc>(context).add(TitleChange(value));
  }
}
