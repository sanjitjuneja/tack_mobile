import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';
import 'package:tacks/src/add_edit_tack/ui/widgets/counter_offer_section.dart';
import 'package:tacks/src/add_edit_tack/ui/widgets/description_section.dart';
import 'package:tacks/src/add_edit_tack/ui/widgets/price_section.dart';
import 'package:tacks/src/add_edit_tack/ui/widgets/time_section.dart';
import 'package:tacks/src/add_edit_tack/ui/widgets/title_section.dart';

class AddEditTackForm extends StatelessWidget {
  const AddEditTackForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditTackBloc, AddEditTackState>(
      builder: (_, AddEditTackState state) {
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
                      TitleSection(state: state),
                      const SizedBox(height: 12),
                      PriceSection(state: state),
                      const SizedBox(height: 12),
                      DescriptionSection(state: state),
                      const SizedBox(height: 12),
                      TimeSection(state: state),
                      const SizedBox(height: 12),
                      CounterOfferSection(state: state),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 40),
              child: state.isAdd
                  ? AppCircleButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      isDisabled: !state.isReadyToProceed,
                      labelKey: 'addEditTackScreen.createTackButton',
                      withFeedback: true,
                      onTap: () => _onCreateTackPressed(context),
                    )
                  : AppCircleButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      isDisabled: !state.isReadyToProceed,
                      labelKey: 'addEditTackScreen.updateTackButton',
                      onTap: () => _onEditTackPressed(context),
                    ),
            ),
          ],
        );
      },
    );
  }

  void _onCreateTackPressed(
    BuildContext context,
  ) {
    BlocProvider.of<AddEditTackBloc>(context).add(const CreateTackRequest());
  }

  void _onEditTackPressed(
    BuildContext context,
  ) {
    BlocProvider.of<AddEditTackBloc>(context).add(const EditTackRequest());
  }
}
