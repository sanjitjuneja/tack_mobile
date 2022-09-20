import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/add_edit_tack_bloc.dart';
import 'widgets/counter_offer_section.dart';
import 'widgets/description_section.dart';
import 'widgets/price_section.dart';
import 'widgets/time_section.dart';
import 'widgets/title_section.dart';

import 'widgets/group_section.dart';

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
              child: AppScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GroupSection(state: state),
                  const SizedBox(height: 34),
                  TitleSection(state: state),
                  const SizedBox(height: 12),
                  PriceSection(state: state),
                  const SizedBox(height: 12),
                  DescriptionSection(state: state),
                  const SizedBox(height: 34),
                  TimeSection(state: state),
                  const SizedBox(height: 12),
                  CounterOfferSection(state: state),
                ],
              ),
            ),
            const SizedBox(height: 4),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 40),
              child: state.isAdd
                  ? AppCircleButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      labelKey: 'addEditTackScreen.createTackButton',
                      withFeedback: true,
                      onTap: () => _onCreateTackPressed(context),
                    )
                  : AppCircleButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
