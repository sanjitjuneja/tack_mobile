import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/edit_tack/bloc/edit_tack_bloc.dart';

class DescriptionSection extends StatelessWidget {
  final EditTackState state;

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
          labelKey: 'editTack.descriptionSection.title',
          headerWeight: HeaderWeight.heavy,
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: 'editTack.descriptionSection.placeholder',
          initialText: state.descriptionData.description,
          minLines: 3,
          onTextChange: (String value) => _onDescriptionChange(context, value),
        ),
      ],
    );
  }

  void _onDescriptionChange(BuildContext context, String value) {
    BlocProvider.of<EditTackBloc>(context).add(DescriptionChange(value));
  }
}
