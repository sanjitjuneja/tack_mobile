import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Customer Support',
              style: AppTextTheme.manrope24SemiBold.copyWith(
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.positiveColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.shadowColor,
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 45,
                  bottom: 50,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Please Contact The Following Number',
                      style: AppTextTheme.manrope18Bold.copyWith(
                        color: AppTheme.accentColor,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Text(
                      '832-498-5095',
                      style: AppTextTheme.manrope18Bold.copyWith(
                        color: AppTheme.accentColor,
                      ),
                    ),
                    const SizedBox(height: 38),
                    AppImagesTheme.alertRequest,
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 42),
                      child: Text(
                        'Our team will reach out to you as soon as possible with a response',
                        style: AppTextTheme.manrope14Regular,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
