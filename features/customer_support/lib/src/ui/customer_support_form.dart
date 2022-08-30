import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class CustomerSupportForm extends StatelessWidget {
  const CustomerSupportForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, 'customerSupportScreen.title'),
            style: AppTextTheme.manrope24SemiBold.copyWith(
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
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
            child: Column(
              children: <Widget>[
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      'customerSupportScreen.descriptionTitle',
                    ),
                    style: AppTextTheme.manrope18Bold.copyWith(
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterI18n.translate(
                    context,
                    'customerSupportScreen.contactNumber',
                  ),
                  style: AppTextTheme.manrope18Bold.copyWith(
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 38),
                AppImagesTheme.alertRequest,
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: Text(
                    FlutterI18n.translate(
                      context,
                      'customerSupportScreen.description',
                    ),
                    style: AppTextTheme.manrope14Regular
                        .copyWith(color: AppTheme.textPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }
}
