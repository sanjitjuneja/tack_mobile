import 'package:flutter/material.dart';

import '../../core_ui.dart';

class InformationField extends StatelessWidget {
  final String description;
  final String information;

  const InformationField({
    required this.description,
    required this.information,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              description,
              style: AppTextTheme.manrope14Light.copyWith(
                color: AppTheme.k,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  information,
                  style: AppTextTheme.manrope20Medium.copyWith(
                    color: AppTheme.p,
                  ),
                ),
                AppImagesTheme.fieldSuccessIcon,
              ],
            )
          ],
        ),
      ),
    );
  }
}
