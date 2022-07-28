import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:tacks/src/edit_tack/bloc/edit_tack_bloc.dart';
import 'package:tacks/src/edit_tack/models/time_estimation_data.dart';

class TimeSection extends StatelessWidget {
  final EditTackState state;

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
          labelKey: 'editTack.timeSection.title',
          headerWeight: HeaderWeight.heavy,
        ),
        const SizedBox(height: 12),
        Flexible(
          child: Row(
            children: <Widget>[
              const SizedBox(width: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 90),
                child: AppTextField(
                  placeholder: 'editTack.timeSection.placeholder',
                  initialText: state.timeEstimationData.timeEstimation,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 14.0,
                  ),
                  maxLines: 1,
                  hasShadow: false,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
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
                        'editTack.timeSection.options.first',
                      ),
                      TimeEstimationIn.hour: FlutterI18n.translate(
                        context,
                        'editTack.timeSection.options.second',
                      ),
                    },
                    initialValue: state.timeEstimationData.timeEstimationIn,
                    onChangeValue: (TimeEstimationIn value) =>
                        _onTimeEstimationInChange(context, value),
                    textStyle: AppTextTheme.manrope14Medium,
                  ),
                ),
              ),
              const SizedBox(width: 36),
            ],
          ),
        ),
      ],
    );
  }

  void _onTimeChange(BuildContext context, String value) {
    BlocProvider.of<EditTackBloc>(context).add(TimeEstimationChange(value));
  }

  void _onTimeEstimationInChange(BuildContext context, TimeEstimationIn value) {
    BlocProvider.of<EditTackBloc>(context).add(TimeEstimationInChange(value));
  }
}
