import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'package:tacks/src/rate_tack_user/bloc/rate_tack_user_bloc.dart';
import 'package:tacks/src/rate_tack_user/ui/widgets/comment_field.dart';
import 'package:tacks/src/rate_tack_user/ui/widgets/rating_section.dart';

class RateTackUserForm extends StatelessWidget {
  const RateTackUserForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RateTackUserBloc, RateTackUserState>(
      builder: (_, RateTackUserState state) {
        return Column(
          children: <Widget>[
            Expanded(
              child: ResizingScrollableLayout(
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  Flexible(
                    child: RatingSection(
                      state: state,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 60),
                        CommentField(
                          state: state,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 40),
              child: AppCircleButton(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                isDisabled: !state.isReadyToProceed,
                labelKey: 'rateTackScreen.confirmButtonLabel',
                onTap: () => _onSentRatingPressed(context),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onSentRatingPressed(BuildContext context) {
    BlocProvider.of<RateTackUserBloc>(context).add(const SendRating());
  }
}
