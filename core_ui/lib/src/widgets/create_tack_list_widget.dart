import 'package:core/localization/app_localization.dart';
import 'package:core/utils/currency_utils.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class CreateTackListWidget extends StatelessWidget {
  final CreateTackModel tack;
  final Function onEditPressed;
  final Function? onRemovePressed;

  const CreateTackListWidget({
    required this.tack,
    required this.onEditPressed,
    this.onRemovePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppTheme.shadowColor,
            offset: Offset(0, 7),
            spreadRadius: -5,
            blurRadius: 6,
          ),
        ],
        color: AppTheme.positiveColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 12,
              right: 12,
              bottom: 15,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        tack.tackTitle,
                        style: AppTextTheme.manrope16SemiBold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Text(
                      dollarFormat.format(tack.price),
                      style: AppTextTheme.manrope24Bold.copyWith(
                        color: AppTheme.grassColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TackTimeWidget(
                  time: tack.time,
                  tackerName: tack.status,
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  tack.description,
                  style: AppTextTheme.manrope12Light,
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    if (tack.isSavedTack) ...<Widget>{
                      Flexible(
                        flex: 1,
                        child: AppButton(
                          text: AppLocalizations.of(context).value(
                            'button.remove',
                          ),
                          height: 40,
                          backgroundColor: AppTheme.positiveColor,
                          textStyle: AppTextTheme.manrope14Medium.copyWith(
                            color: AppTheme.buttonTextSecondaryColor,
                          ),
                          borderSide: const BorderSide(
                            width: 1,
                            color: AppTheme.lightButtonBorder,
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 10),
                              spreadRadius: -8,
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 11),
                    },
                    Flexible(
                      flex: 2,
                      child: AppButton(
                        image: AppImagesTheme.edit,
                        text: AppLocalizations.of(context).value(
                          'button.editAndPublish',
                        ),
                        height: 40,
                        backgroundColor: AppTheme.grassColor,
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppTheme.positiveColor,
                        ),
                        shadows: const [
                          BoxShadow(
                            color: AppTheme.shadowColor,
                            offset: Offset(0, 10),
                            spreadRadius: -8,
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
