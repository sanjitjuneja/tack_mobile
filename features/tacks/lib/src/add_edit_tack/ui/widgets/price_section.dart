import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';

class PriceSection extends StatelessWidget {
  static const String _localizationPath = 'addEditTackScreen.priceSection.';

  final AddEditTackState state;

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
          labelKey: '${_localizationPath}title',
        ),
        const SizedBox(height: 12),
        AppTextField(
          placeholder: '${_localizationPath}placeholder',
          initialText: state.priceData.price,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters:
              CurrencyUtility.dollarInputFormatters(maxValue: 1000),
          hasShadow: false,
          backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
          onTextChange: (String value) => _onPriceChange(context, value),
        ),
      ],
    );
  }

  void _onPriceChange(
    BuildContext context,
    String value,
  ) {
    BlocProvider.of<AddEditTackBloc>(context).add(
      PriceChange(const CurrencyFormatter().removeFormat(value)),
    );
  }
}
