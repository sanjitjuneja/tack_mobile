import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/pay_for_tack_bloc.dart';
import '/src/widgets/payment_method_tile.dart';

class PayForTackForm extends StatelessWidget {
  const PayForTackForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayForTackBloc, PayForTackState>(
      builder: (_, PayForTackState state) {
        return Column(
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(
                  context,
                  'payForTack.title',
                ),
                style: AppTextTheme.manrope24SemiBold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: CupertinoTextField(
                readOnly: true,
                textAlign: TextAlign.center,
                controller: TextEditingController(
                  text: CurrencyUtility.dollarFormat.format(
                    state.tackOfferPrice,
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
            ),
            const SizedBox(height: 6),
            if (state.currentFeePercent == 0) ...<Widget>[
              RichText(
                text: TextSpan(
                  text: '${FlutterI18n.translate(
                    context,
                    'payForTack.listedTackPrice',
                  )} - ',
                  style: AppTextTheme.manrope14Regular.copyWith(
                    color: AppTheme.textHeavyHintColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: FlutterI18n.translate(
                        context,
                        'payForTack.noTransactionFee',
                      ),
                      style: AppTextTheme.manrope14Regular.copyWith(
                        color: AppTheme.grassColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...<Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: CurrencyUtility.dollarFormat.format(
                      state.amountInDollarFormatWithFee,
                    ),
                    style: AppTextTheme.manrope12Medium.copyWith(
                      color: AppTheme.grassColor,
                    ),
                    children: <TextSpan>[
                      if (state.currentMinFeeAmount > 0 &&
                          state.currentMaxFeeAmount > 0) ...<TextSpan>[
                        TextSpan(
                          text: FlutterI18n.translate(
                            context,
                            'payForTack.feeLabelWithMinAndMax',
                            translationParams: <String, String>{
                              'fee_percent':
                                  state.currentFeePercent.toStringAsFixed(0),
                              'min_fee': state.currentMinFeeAmount
                                  .toDouble()
                                  .toDollarFormat
                                  .toStringAsFixed(2),
                              'max_fee': state.currentMaxFeeAmount
                                  .toDouble()
                                  .toDollarFormat
                                  .toStringAsFixed(2),
                            },
                          ),
                          style: AppTextTheme.manrope14Regular.copyWith(
                            color: AppTheme.textHeavyHintColor,
                          ),
                        ),
                      ] else if (state.currentMinFeeAmount > 0) ...<TextSpan>[
                        TextSpan(
                          text: FlutterI18n.translate(
                            context,
                            'payForTack.feeLabelWithMin',
                            translationParams: <String, String>{
                              'fee_percent':
                                  state.currentFeePercent.toStringAsFixed(0),
                              'min_fee': state.currentMinFeeAmount
                                  .toDouble()
                                  .toDollarFormat
                                  .toStringAsFixed(2),
                            },
                          ),
                          style: AppTextTheme.manrope14Regular.copyWith(
                            color: AppTheme.textHeavyHintColor,
                          ),
                        ),
                      ] else if (state.currentMaxFeeAmount > 0) ...<TextSpan>[
                        TextSpan(
                          text: FlutterI18n.translate(
                            context,
                            'payForTack.feeLabelWithMax',
                            translationParams: <String, String>{
                              'fee_percent':
                                  state.currentFeePercent.toStringAsFixed(0),
                              'max_fee': state.currentMaxFeeAmount
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
                            'payForTack.feeLabel',
                            translationParams: <String, String>{
                              'fee_percent':
                                  state.currentFeePercent.toStringAsFixed(0),
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
              ),
            ],
            const Spacer(),
            if (state.isLoading) ...<Widget>[
              AppProgressIndicator(
                indicatorSize: ProgressIndicatorSize.medium,
                backgroundColor: AppTheme.transparentColor,
                indicatorColor: AppTheme.progressInterfaceDarkColor,
              ),
            ] else if (state.hasError) ...<Widget>[
              Container(
                alignment: Alignment.center,
                child: CupertinoButton(
                  onPressed: () => _onRefreshAction(context),
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.refresh_rounded,
                    color: AppTheme.progressInterfaceDarkColor,
                    size: 60,
                  ),
                ),
              ),
            ] else ...<Widget>[
              if (state.selectedPaymentMethod.isTackBalance) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppIconsTheme.tack(size: 35),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: FlutterI18n.translate(
                      context,
                      'payForTack.tack',
                    ),
                    subtitle: FlutterI18n.translate(
                      context,
                      'payForTack.balance',
                      translationParams: <String, String>{
                        'balance': state.userBalance.usdBalance.toStringAsFixed(
                          2,
                        ),
                      },
                    ),
                    isColored: true,
                  ),
                ),
              ] else if (state.selectedPaymentMethod.card != null) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppNetworkImageWidget(
                      state.selectedPaymentMethod.card!.cardData.imageUrl,
                      placeholderIcon: AppIconsTheme.card,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                      isShadowBorder: false,
                    ),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: state.selectedPaymentMethod.card!.cardData.brand,
                    subtitle:
                        '*****${state.selectedPaymentMethod.card!.cardData.last4}',
                    isColored: true,
                  ),
                ),
              ] else if (state.selectedPaymentMethod.bankAccount !=
                  null) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppNetworkImageWidget(
                      state.selectedPaymentMethod.bankAccount!.imageUrl,
                      placeholderIcon: AppIconsTheme.bank,
                      boxShape: BoxShape.rectangle,
                      boxFit: BoxFit.fitWidth,
                      isShadowBorder: false,
                    ),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: state.selectedPaymentMethod.bankAccount!.bankName,
                    subtitle: state
                        .selectedPaymentMethod.bankAccount!.bankAccountType,
                    isColored: true,
                  ),
                ),
              ] else if (state.selectedPaymentMethod.isApplePay) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppIconsTheme.applePay(),
                    isSentenceCase: false,
                    onTap: () => _onSelectPaymentMethod(context),
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.applePay',
                    ),
                    isColored: true,
                  ),
                ),
              ] else if (state.selectedPaymentMethod.isGooglePay) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppIconsTheme.googlePay(),
                    isSentenceCase: false,
                    onTap: () => _onSelectPaymentMethod(context),
                    title: FlutterI18n.translate(
                      context,
                      'paymentSettingsScreen.googlePay',
                    ),
                    isColored: true,
                  ),
                ),
              ] else ...<Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: PaymentMethodTile(
                    leadingIcon: AppIconsTheme.bank(),
                    onTap: () => _onSelectPaymentMethod(context),
                    title: FlutterI18n.translate(
                      context,
                      'payForTack.selectPaymentMethod',
                    ),
                    isSentenceCase: false,
                    subtitle: FlutterI18n.translate(
                      context,
                      'payForTack.bankOrCard',
                    ),
                    isColored: true,
                  ),
                ),
              ],
            ],
            const Spacer(flex: 8),
            Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: TimeLeftWidget(
                    builder: (_, __) {
                      return AppCircleButton(
                        labelKey: 'payForTack.beginTack',
                        expanded: false,
                        isDisabled: !state.isReadyToProceed,
                        onTap: () => _onPayForTackTap(context),
                      );
                    },
                    tillTime: state.offer.expiredAt,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void _onPayForTackTap(BuildContext context) {
    BlocProvider.of<PayForTackBloc>(context).add(
      const MakePayForTackRequest(),
    );
  }

  void _onSelectPaymentMethod(BuildContext context) {
    BlocProvider.of<PayForTackBloc>(context).add(
      const SelectPaymentMethodAction(),
    );
  }

  void _onRefreshAction(BuildContext context) {
    BlocProvider.of<PayForTackBloc>(context).add(
      const InitialLoad(),
    );
  }
}
