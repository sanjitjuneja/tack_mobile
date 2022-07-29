import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/edit_tack/bloc/edit_tack_bloc.dart';

class TitleSection extends StatelessWidget {
  final EditTackState state;

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
          labelKey: 'editTack.titleSection.title',
          headerWeight: HeaderWeight.heavy,
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: 'editTack.titleSection.placeholder',
          initialText: state.titleData.title,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onTextChange: (String value) => _onTitleChange(context, value),
        ),
      ],
    );
  }

  void _onTitleChange(BuildContext context, String value) {
    BlocProvider.of<EditTackBloc>(context).add(TitleChange(value));
  }
}
