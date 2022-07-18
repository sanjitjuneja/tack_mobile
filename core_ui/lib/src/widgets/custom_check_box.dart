import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final Image negativeImage;
  final Image positiveImage;
  final Function(bool) onChanged;

  const CustomCheckBox({
    required this.value,
    required this.negativeImage,
    required this.positiveImage,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
        });
        widget.onChanged(value);
      },
      child: value ? widget.positiveImage : widget.negativeImage,
    );
  }
}
