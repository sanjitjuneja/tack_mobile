import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../bloc/add_edit_tack_bloc.dart';
import '../../models/time_estimation_data.dart';

class TimeSection extends StatelessWidget {
  static const String _localizationPath = 'addEditTackScreen.timeSection.';

  final AddEditTackState state;

  const TimeSection({
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
          isRequired: state.timeEstimationData.isRequired,
        ),
        const SizedBox(height: 12),
        Flexible(
          child: Row(
            children: <Widget>[
              const SizedBox(width: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 90),
                child: AppTextField(
                  initialText: state.timeEstimationData.timeEstimation,
                  placeholder: '${_localizationPath}placeholder',
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 10.0,
                  ),
                  hasShadow: false,
                  scrollPadding: 60,
                  backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter>[
                    RangeNumberFormatter(
                        max: state.timeEstimationData.maxValue),
                  ],
                  onTextChange: (String value) => _onTimeChange(context, value),
                ),
              ),
              const SizedBox(width: 10),
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: DefaultTabController(
                  length: 2,
                  child: AppSegmentController(
                    tabs: <TimeEstimationIn, String>{
                      TimeEstimationIn.min: FlutterI18n.translate(
                        context,
                        '${_localizationPath}options.first',
                      ),
                      TimeEstimationIn.hour: FlutterI18n.translate(
                        context,
                        '${_localizationPath}options.second',
                      ),
                    },
                    initialValue: state.timeEstimationData.timeEstimationIn,
                    onChangeValue: (TimeEstimationIn value) =>
                        _onTimeEstimationInChange(context, value),
                    height: 30,
                    textStyle: AppTextTheme.manrope14Medium,
                  ),
                ),
              ),
              const SizedBox(width: 38),
            ],
          ),
        ),
      ],
    );
  }

  void _onTimeChange(
    BuildContext context,
    String value,
  ) {
    BlocProvider.of<AddEditTackBloc>(context).add(TimeEstimationChange(value));
  }

  void _onTimeEstimationInChange(
    BuildContext context,
    TimeEstimationIn value,
  ) {
    BlocProvider.of<AddEditTackBloc>(context)
        .add(TimeEstimationInChange(value));
  }
}
