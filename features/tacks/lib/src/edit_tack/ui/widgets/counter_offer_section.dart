import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:tacks/src/edit_tack/bloc/edit_tack_bloc.dart';

class CounterOfferSection extends StatefulWidget {
  final EditTackState state;

  const CounterOfferSection({
    super.key,
    required this.state,
  });

  @override
  State<CounterOfferSection> createState() => _CounterOfferSectionState();
}

class _CounterOfferSectionState extends State<CounterOfferSection> {
  static const Duration _animationDuration = Duration(milliseconds: 350);

  final GlobalKey _hintWidgetKey = GlobalKey();

  bool showHint = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            SectionHeaderWidget(
              labelKey: 'editTack.counterOfferSection.title',
              headerWeight: HeaderWeight.heavy,
            ),
            const SizedBox(width: 10),
            const Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: DefaultTabController(
                length: 2,
                child: AppSegmentController(
                  tabs: <bool, String>{
                    false: FlutterI18n.translate(
                      context,
                      'editTack.counterOfferSection.options.first',
                    ),
                    true: FlutterI18n.translate(
                      context,
                      'editTack.counterOfferSection.options.second',
                    ),
                  },
                  initialValue: widget.state.counterOfferData.allow,
                  onChangeValue: _onCounterOfferOptionChange,
                  textStyle: AppTextTheme.manrope14Medium,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _onHintPressed,
              child: AppIconsTheme.prompt(),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedSize(
          duration: _animationDuration,
          child: showHint
              ? Padding(
                  key: _hintWidgetKey,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      'createTack.promptText',
                    ),
                    style: AppTextTheme.manrope12SemiBold.copyWith(
                      color: AppTheme.textHeavyHintColor,
                    ),
                  ),
                )
              : const SizedBox(
                  width: double.infinity,
                ),
        ),
      ],
    );
  }

  void _onCounterOfferOptionChange(
    bool allowCounterOffer,
  ) {
    BlocProvider.of<EditTackBloc>(context)
        .add(CounterOfferOptionChange(allowCounterOffer));
  }

  void _onHintPressed() {
    setState(() => showHint = !showHint);
    Future.delayed(
      _animationDuration,
      () {
        final BuildContext? hintWidgetContext = _hintWidgetKey.currentContext;
        if (mounted && hintWidgetContext != null) {
          Scrollable.ensureVisible(
            hintWidgetContext,
            duration: _animationDuration,
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }
}
