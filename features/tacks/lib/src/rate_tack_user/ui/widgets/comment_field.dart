import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tacks/src/rate_tack_user/bloc/rate_tack_user_bloc.dart';

class CommentField extends StatelessWidget {
  final RateTackUserState state;

  const CommentField({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          AppTextField(
            placeholder: 'rateTackScreen.commentPlaceholder',
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
            ),
            minLines: 5,
            hasDecoration: false,
            inputFormatters: <TextInputFormatter>[
              WordsLengthFormatter(state.commentData.maxWords),
            ],
            onTextChange: (String value) => _onCommentChange(context, value),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: TextFieldFooter(
              labelKey: 'rateTackScreen.commentFooterText',
              content: state.commentData.wordsLeft.toString(),
              maxContent: state.commentData.maxWords.toString(),
            ),
          ),
        ],
      ),
    );
  }

  void _onCommentChange(
    BuildContext context,
    String comment,
  ) {
    BlocProvider.of<RateTackUserBloc>(context).add(CommentChange(comment));
  }
}
