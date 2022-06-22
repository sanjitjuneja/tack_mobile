import 'package:flutter/material.dart';

import '../../core_ui.dart';

class SearchFieldWidget extends StatefulWidget {
  final String query;
  final String hintText;
  final Function onCrossPressed;
  final Function onFilterPressed;
  final Function(String) onSearch;

  const SearchFieldWidget({
    required this.query,
    required this.hintText,
    required this.onSearch,
    required this.onCrossPressed,
    required this.onFilterPressed,
    Key? key,
  }) : super(key: key);

  @override
  _SearchFieldWidgetState createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    widget.query != '' ? textController.text = widget.query : null;
    super.initState();
  }

  String enteredText = '';

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 58,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.shadowColor,
              offset: Offset(0, 10),
              spreadRadius: -5,
              blurRadius: 12,
            ),
          ],
        ),
        child: TextFormField(
          cursorColor: AppTheme.hintColor,
          onFieldSubmitted: widget.onSearch,
          onChanged: (String val) {
            setState(() {
              enteredText = val;
            });
          },
          focusNode: _focusNode,
          controller: textController,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.positiveColor,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppTheme.positiveColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppTheme.positiveColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppTheme.positiveColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: widget.hintText,
            hintStyle: AppTextTheme.manrope16Light.copyWith(
              color: AppTheme.hintColor,
            ),
            prefixIcon: AppImagesTheme.search,
          ),
        ),
      ),
    );
  }
}
