import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/edit_tack/bloc/edit_tack_bloc.dart';

class PriceSection extends StatelessWidget {
  final EditTackState state;

  const PriceSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SectionHeaderWidget(
          labelKey: 'editTack.priceSection.title',
          headerWeight: HeaderWeight.heavy,
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: 'editTack.priceSection.placeholder',
          initialText: state.priceData.price,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters: CurrencyUtility.dollarInputFormatters,
          onTextChange: (String value) => _onPriceChange(context, value),
        ),
      ],
    );
  }

  void _onPriceChange(BuildContext context, String value) {
    BlocProvider.of<EditTackBloc>(context).add(
      PriceChange(const CurrencyFormatter().removeFormat(value)),
    );
  }
}
