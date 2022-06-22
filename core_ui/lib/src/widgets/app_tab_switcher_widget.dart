import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final List<String> values;
  final ValueChanged onToggleCallback;

  const AnimatedToggle({
    required this.values,
    required this.activeColor,
    required this.inactiveColor,
    required this.onToggleCallback,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initPosition = true;
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double togglerHalfWidth =
        (MediaQuery.of(context).size.width - 16) / 2;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            initPosition = !initPosition;
            var index = 0;
            if (!initPosition) {
              index = 1;
            }
            setState(() {
              selectedTabIndex = index;
            });
            widget.onToggleCallback(index);
          },
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.inactiveColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                widget.values.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    widget.values[index],
                    style: AppTextTheme.manrope18Medium.copyWith(
                      color: widget.activeColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedAlign(
          curve: Curves.decelerate,
          alignment:
              initPosition ? Alignment.centerLeft : Alignment.centerRight,
          duration: const Duration(milliseconds: 250),
          child: Container(
            height: 43,
            width: togglerHalfWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.activeColor,
              border: Border.all(
                color: widget.inactiveColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              widget.values[selectedTabIndex],
              style: AppTextTheme.manrope18Medium.copyWith(
                color: widget.inactiveColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
