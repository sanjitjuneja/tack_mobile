import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Account',
                        style: AppTextTheme.manrope32Bold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      const SizedBox(height: 26),
                      AppTextFormField(
                        hintText: 'Full Name',
                        onChanged: (String value) {},
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: AppTheme.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            right: 21,
                            left: 21,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Phone Number',
                                style: AppTextTheme.manrope14Regular.copyWith(
                                  color: AppTheme.k,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '+1 502-384-1845',
                                    style:
                                        AppTextTheme.manrope20Medium.copyWith(
                                      color: AppTheme.p,
                                    ),
                                  ),
                                  AppIconsTheme.checkMarkFilled(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 68,
                        decoration: BoxDecoration(
                          color: AppTheme.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            right: 21,
                            left: 21,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Venmo Account',
                                style: AppTextTheme.manrope14Regular.copyWith(
                                  color: AppTheme.k,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '@exampleVenmo',
                                    style:
                                        AppTextTheme.manrope20Medium.copyWith(
                                      color: AppTheme.p,
                                    ),
                                  ),
                                  AppIconsTheme.checkMarkFilled(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            KeyboardVisibilityWidget(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  RoundedCustomButton(
                    text: 'Relink Venmo',
                    isEnabled: false,
                    borderRadius: BorderRadius.circular(35),
                    disabledTextStyle: AppTextTheme.manrope16Medium.copyWith(
                      color: AppTheme.textDisabledColor,
                    ),
                    disabledBackgroundColor: AppTheme.textFieldBackgroundColor,
                    textStyle: AppTextTheme.manrope16Medium.copyWith(
                      color: AppTheme.positiveColor,
                    ),
                    backgroundColor: AppTheme.grassColor,
                  ),
                  const SizedBox(height: 20),
                  RoundedCustomButton(
                    text: 'Relink Venmo',
                    isEnabled: false,
                    borderRadius: BorderRadius.circular(35),
                    disabledTextStyle: AppTextTheme.manrope16Medium.copyWith(
                      color: AppTheme.textDisabledColor,
                    ),
                    disabledBackgroundColor: AppTheme.textFieldBackgroundColor,
                    textStyle: AppTextTheme.manrope16Medium.copyWith(
                      color: AppTheme.positiveColor,
                    ),
                    backgroundColor: AppTheme.grassColor,
                  ),
                  const SizedBox(height: 20),
                  RoundedCustomButton(
                    text: 'Relink Venmo',
                    isEnabled: false,
                    borderRadius: BorderRadius.circular(35),
                    disabledTextStyle: AppTextTheme.manrope16Medium.copyWith(
                      color: AppTheme.textDisabledColor,
                    ),
                    disabledBackgroundColor: AppTheme.textFieldBackgroundColor,
                    textStyle: AppTextTheme.manrope16Medium.copyWith(
                      color: AppTheme.positiveColor,
                    ),
                    backgroundColor: AppTheme.grassColor,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
