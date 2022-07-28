import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/edit_tack/bloc/edit_tack_bloc.dart';
import 'package:tacks/src/edit_tack/ui/widgets/counter_offer_section.dart';
import 'package:tacks/src/edit_tack/ui/widgets/description_section.dart';
import 'package:tacks/src/edit_tack/ui/widgets/price_section.dart';
import 'package:tacks/src/edit_tack/ui/widgets/time_section.dart';
import 'package:tacks/src/edit_tack/ui/widgets/title_section.dart';

class EditTackForm extends StatelessWidget {
  const EditTackForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTackBloc, EditTackState>(
      builder: (_, EditTackState state) {
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
                      Text(
                        FlutterI18n.translate(
                          context,
                          'editTack.description',
                          translationParams: <String, String>{
                            'groupName': 'Callaway Group',
                          },
                        ),
                        style: AppTextTheme.manrope13Medium.copyWith(
                          color: AppTheme.textDescriptionColor,
                        ),
                      ),
                      const SizedBox(height: 24),
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
              child: AppCircleButton(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                isDisabled: !state.isReadyToProceed,
                labelKey: 'editTack.updateTackButton',
                onTap: () => _onEditTackPressed(context),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onEditTackPressed(
    BuildContext context,
  ) {
    BlocProvider.of<EditTackBloc>(context).add(const EditTackRequest());
  }
}
