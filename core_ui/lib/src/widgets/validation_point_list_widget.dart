import 'package:flutter/cupertino.dart';

import 'validation_point_widget.dart';

class ValidationPointListWidget extends StatelessWidget {
  final List<ValidationPointWidget> children;

  const ValidationPointListWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}
