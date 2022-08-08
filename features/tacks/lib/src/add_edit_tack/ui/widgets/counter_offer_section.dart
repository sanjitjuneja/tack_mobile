import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';

class CounterOfferSection extends StatefulWidget {
  final AddEditTackState state;

  const CounterOfferSection({
    super.key,
    required this.state,
  });

  @override
  State<CounterOfferSection> createState() => _CounterOfferSectionState();
}

class _CounterOfferSectionState extends State<CounterOfferSection> {
  static const String _localizationPath =
      'addEditTackScreen.counterOfferSection.';
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
              labelKey: '${_localizationPath}title',
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
                      '${_localizationPath}options.first',
                    ),
                    true: FlutterI18n.translate(
                      context,
                      '${_localizationPath}options.second',
                    ),
                  },
                  initialValue: widget.state.counterOfferData.allow,
                  onChangeValue: _onCounterOfferOptionChange,
                  height: 30,
                  textStyle: AppTextTheme.manrope14Medium,
                ),
              ),
            ),
            const SizedBox(width: 10),
            OpacityOnTapContainer(
              onTap: _onHintPressed,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AppIconsTheme.prompt(size: 20),
              ),
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
                      '${_localizationPath}hint',
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
    BlocProvider.of<AddEditTackBloc>(context)
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
