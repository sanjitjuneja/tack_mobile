import 'package:flutter/material.dart';

import '../../core_ui.dart';

final InputDecoration inputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 16,
  ),
  hintStyle: AppTextTheme.manrope18Medium,
  border: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: Colors.blue,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: Colors.yellow,
    ),
  ),
  counterStyle: AppTextTheme.manrope18Medium,
  errorStyle: AppTextTheme.manrope14Medium,
);
