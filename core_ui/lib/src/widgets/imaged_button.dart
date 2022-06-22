import 'package:flutter/material.dart';

import '../../core_ui.dart';

class ImagedButton extends StatelessWidget {
  final Function onTap;

  const ImagedButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 58,
      decoration: BoxDecoration(
        color: AppTheme.positiveColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppTheme.shadowColor,
            offset: Offset(0, 10),
            spreadRadius: -5,
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: AppImagesTheme.filter,
      ),
    );
  }
}
