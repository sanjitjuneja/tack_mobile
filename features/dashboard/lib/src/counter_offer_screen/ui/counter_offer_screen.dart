import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/counter_offer_screen/ui/counter_offer_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterOfferScreen extends StatelessWidget {
  const CounterOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          withResult: true,
        ),
        child: const SafeArea(
          child: KeyboardDismissible(
            child: CounterOfferForm(),
          ),
        ),
      ),
    );
  }
}
