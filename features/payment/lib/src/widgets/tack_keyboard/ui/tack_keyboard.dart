import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/tack_keyboard_bloc.dart';
import '../utils/keyboard_symbols.dart';

class TackKeyboard extends StatelessWidget {
  final String subtitleKey;
  final bool hasLimits;
  final String? minErrorKey;
  final String? maxErrorKey;
  final double minAmount;
  final double maxAmount;
  final double amount;
  final double feePercent;
  final int feeMinAmount;
  final int feeMaxAmount;
  final ValueSetter<double> onChanged;

  const TackKeyboard({
    Key? key,
    required this.subtitleKey,
    required this.amount,
    required this.onChanged,
    this.minErrorKey,
    this.maxErrorKey,
    this.feePercent = 0.0,
    this.feeMinAmount = 0,
    this.feeMaxAmount = 0,
    this.minAmount = Constants.minDepositLimitAmount,
    this.maxAmount = Constants.maxDepositLimitAmount,
    this.hasLimits = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TackKeyboardBloc, TackKeyboardState>(
      listener: (_, TackKeyboardState state) {
        final double resultValue = hasLimits
            ? state.isInLimitsRange(minAmount, maxAmount)
                ? state.parsedValue
                : 0.0
            : state.parsedValue;

        onChanged(resultValue);
      },
      builder: (_, TackKeyboardState state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              if (hasLimits) ...<Widget>[
                CupertinoTextField(
                  readOnly: true,
                  textAlign: TextAlign.center,
                  controller: TextEditingController(
                    text: CurrencyUtility.dollarFormat.format(
                      state.parsedValue,
                    ),
                  ),
                  style: AppTextTheme.manrope38Bold.copyWith(
                    color: AppTheme.grassColor,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: AppTheme.dividerColor,
                      ),
                    ),
                  ),
                ),
              ] else ...<Widget>[
                CupertinoTextField(
                  readOnly: true,
                  textAlign: TextAlign.center,
                  controller: TextEditingController(
                    text: CurrencyUtility.dollarFormat.format(
                      state.parsedValue,
                    ),
                  ),
                  style: AppTextTheme.manrope38Bold.copyWith(
                    color: AppTheme.grassColor,
                  ),
                  decoration: const BoxDecoration(),
                ),
              ],
              const SizedBox(height: 6),
              if (state.isInLimitsRange(minAmount, maxAmount) ||
                  state.value.isEmpty) ...<Widget>[
                RichText(
                  text: TextSpan(
                    text: FlutterI18n.translate(
                      context,
                      subtitleKey,
                    ),
                    style: AppTextTheme.manrope14Regular.copyWith(
                      color: AppTheme.textHeavyHintColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: CurrencyUtility.dollarFormat.format(amount),
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.grassColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (feePercent > 0 && state.value.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 6),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: CurrencyUtility.dollarFormat.format(
                        state.amountWithFee(
                          feePercent: feePercent,
                          feeMinAmount: feeMinAmount.toDouble().toDollarFormat,
                          feeMaxAmount: feeMaxAmount.toDouble().toDollarFormat,
                        ),
                      ),
                      style: AppTextTheme.manrope12Medium.copyWith(
                        color: AppTheme.grassColor,
                      ),
                      children: <TextSpan>[
                        if (feeMinAmount > 0 && feeMaxAmount > 0) ...<TextSpan>[
                          TextSpan(
                            text: FlutterI18n.translate(
                              context,
                              'addToTackBalanceScreen.feeLabelWithMinAndMax',
                              translationParams: <String, String>{
                                'fee_percent': feePercent.toStringAsFixed(0),
                                'min_fee': feeMinAmount
                                    .toDouble()
                                    .toDollarFormat
                                    .toStringAsFixed(2),
                                'max_fee': feeMaxAmount
                                    .toDouble()
                                    .toDollarFormat
                                    .toStringAsFixed(2),
                              },
                            ),
                            style: AppTextTheme.manrope14Regular.copyWith(
                              color: AppTheme.textHeavyHintColor,
                            ),
                          ),
                        ] else if (feeMinAmount > 0) ...<TextSpan>[
                          TextSpan(
                            text: FlutterI18n.translate(
                              context,
                              'addToTackBalanceScreen.feeLabelWithMin',
                              translationParams: <String, String>{
                                'fee_percent': feePercent.toStringAsFixed(0),
                                'min_fee': feeMinAmount
                                    .toDouble()
                                    .toDollarFormat
                                    .toStringAsFixed(2),
                              },
                            ),
                            style: AppTextTheme.manrope14Regular.copyWith(
                              color: AppTheme.textHeavyHintColor,
                            ),
                          ),
                        ] else if (feeMaxAmount > 0) ...<TextSpan>[
                          TextSpan(
                            text: FlutterI18n.translate(
                              context,
                              'addToTackBalanceScreen.feeLabelWithMax',
                              translationParams: <String, String>{
                                'fee_percent': feePercent.toStringAsFixed(0),
                                'max_fee': feeMaxAmount
                                    .toDouble()
                                    .toDollarFormat
                                    .toStringAsFixed(2),
                              },
                            ),
                            style: AppTextTheme.manrope14Regular.copyWith(
                              color: AppTheme.textHeavyHintColor,
                            ),
                          ),
                        ] else ...<TextSpan>[
                          TextSpan(
                            text: FlutterI18n.translate(
                              context,
                              'addToTackBalanceScreen.feeLabel',
                              translationParams: <String, String>{
                                'fee_percent': feePercent.toStringAsFixed(0),
                              },
                            ),
                            style: AppTextTheme.manrope14Regular.copyWith(
                              color: AppTheme.textHeavyHintColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ] else ...<Widget>[
                if (state.parsedValue < minAmount) ...<Widget>[
                  Text(
                    FlutterI18n.translate(
                      context,
                      minErrorKey!,
                      translationParams: <String, String>{
                        'min_range': minAmount.toStringAsFixed(2),
                      },
                    ),
                    textAlign: TextAlign.center,
                    style: AppTextTheme.manrope14Regular.copyWith(
                      color: AppTheme.errorColor,
                    ),
                  ),
                ] else ...<Widget>[
                  Text(
                    FlutterI18n.translate(
                      context,
                      maxErrorKey!,
                      translationParams: <String, String>{
                        'max_range': maxAmount.toStringAsFixed(2),
                      },
                    ),
                    textAlign: TextAlign.center,
                    style: AppTextTheme.manrope14Regular.copyWith(
                      color: AppTheme.errorColor,
                    ),
                  ),
                ],
              ],
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 44,
                ),
              ),
              ...List<Widget>.generate(
                4,
                (rowIndex) => Row(
                  children: List<Widget>.generate(
                    3,
                    (symbolIndex) {
                      final symbol =
                          keyboardSymbols[(rowIndex * 3) + symbolIndex];
                      return Expanded(
                        child: AspectRatio(
                          aspectRatio: Constants.keyboardSymbolRatio,
                          child: _customDepositNumber(
                            symbol: symbol,
                            onTap: () => _onSymbolTap(context, symbol),
                            onLongPress: () {
                              _onSymbolLongPress(context, symbol);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSymbolTap(
    BuildContext context,
    String symbol,
  ) {
    BlocProvider.of<TackKeyboardBloc>(context).add(
      KeyboardTapInputEvent(
        symbol: symbol,
      ),
    );
  }

  void _onSymbolLongPress(
    BuildContext context,
    String symbol,
  ) {
    BlocProvider.of<TackKeyboardBloc>(context).add(
      KeyboardLongPressInputEvent(
        symbol: symbol,
      ),
    );
  }

  Widget _customDepositNumber({
    required String symbol,
    required VoidCallback onTap,
    required VoidCallback onLongPress,
  }) {
    return OpacityOnTapContainer(
      onTap: onTap,
      onLongPress: onLongPress,
      feedbackType: HapticFeedbackType.heavy,
      withFeedback: true,
      child: symbol != keyboardSymbols[11]
          ? Center(
              child: Text(
                symbol,
                style: AppTextTheme.manrope36SemiBold,
              ),
            )
          : const Center(
              child: Icon(
                Icons.keyboard_backspace,
                size: 30,
                color: AppColors.shuttleGray,
              ),
            ),
    );
  }
}
