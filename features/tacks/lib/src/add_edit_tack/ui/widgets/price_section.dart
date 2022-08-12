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
    return AppTextField(
      initialText: state.priceData.price,
      placeholder: '${_localizationPath}placeholder',
      isRequired: state.priceData.isRequired,
      isInvalid: state.priceData.isInvalid,
      errorTextKey: 'validationErrors.fieldRequired',
      suffix: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Text(
          FlutterI18n.translate(context, '${_localizationPath}suffix'),
          style: AppTextTheme.manrope14Regular
              .copyWith(color: AppTheme.textSecondaryColor),
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: CurrencyUtility.dollarInputFormatters(maxValue: 1000),
      hasShadow: false,
      backgroundColor: AppTheme.textFieldSecondaryBackgroundColor,
      onTextChange: (String value) => _onPriceChange(context, value),
      onFocusLost: _onFocusLost,
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

  void _onFocusLost(TextEditingController controller) {
    final String text = controller.text;
    final String unformattedText = const CurrencyFormatter().removeFormat(text);

    if (unformattedText.isNotEmpty) {
      final double value = double.parse(unformattedText);
      final String newText = CurrencyUtility.dollarFormat.format(value);

      controller.text = newText;
    }
  }
}
