import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home/home_feature.dart';
import 'package:navigation/navigation.dart';

class ConnectThirdPartyScreen extends StatefulWidget {
  const ConnectThirdPartyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ConnectThirdPartyScreen> createState() =>
      _ConnectThirdPartyScreenState();
}

bool isConnected = false;

class _ConnectThirdPartyScreenState extends State<ConnectThirdPartyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 104),
            Text(
              isConnected ? 'Quick Note' : 'Connect Venmo',
              style: AppTextTheme.manrope32Bold.copyWith(
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(height: 54),
            if (isConnected) ...<Widget>{
              AppImagesTheme.success,
            } else ...<Widget>{
              AppImagesTheme.vemoLogo,
            },
            const SizedBox(height: 106),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 49),
              child: Text(
                isConnected
                    ? FlutterI18n.translate(
                        context,
                        'thirdParty.secDescription',
                      )
                    : FlutterI18n.translate(
                        context,
                        'thirdParty.description',
                      ),
                style: AppTextTheme.manrope14Medium.copyWith(
                  color: AppTheme.thirdPartyDescriptionColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 144),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 46),
              child: AppButton(
                labelKey: '',
                onTap: () {
                  if (isConnected) {
                    appLocator.get<AppRouterDelegate>().push(
                          HomeFeature.page(),
                        );
                  } else {
                    setState(() {
                      isConnected = !isConnected;
                    });
                  }
                },
                backgroundColor:
                    isConnected ? AppTheme.grassColor : AppTheme.seaColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
