import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                hintText: 'First Name',
                onChanged: (String value) {},
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                hintText: 'Last Name',
                onChanged: (String value) {},
              ),
              const SizedBox(height: 20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '+1 502-134-1287',
                            style: AppTextTheme.manrope20Medium.copyWith(
                              color: AppTheme.p,
                            ),
                          ),
                          AppImagesTheme.fieldSuccessIcon,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 42),
              RoundedCustomButton(
                text: 'Save Changes',
                backgroundColor: AppTheme.grassColor,
                borderRadius: BorderRadius.circular(35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
