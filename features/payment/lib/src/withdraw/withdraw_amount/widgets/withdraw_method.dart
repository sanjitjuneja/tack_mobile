import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'withdraw_method_type.dart';
import '../bloc/withdraw_amount_bloc.dart';

class WithdrawMethod extends StatelessWidget {
  final String title;
  final WithdrawMethodType withdrawMethodType;

  const WithdrawMethod({
    Key? key,
    required this.title,
    required this.withdrawMethodType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawAmountBloc, WithdrawAmountState>(
      builder: (context, state) {
        final isSelected = withdrawMethodType != state.withdrawMethodType;

        return GestureDetector(
          onTap: () => _onTileTap(context: context, isSelected: isSelected),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.grassColor : AppTheme.primaryColor,
              border: Border.all(
                color: isSelected ? AppTheme.primaryColor : AppTheme.grassColor,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              boxShadow: isSelected
                  ? const <BoxShadow>[
                      BoxShadow(
                        color: AppColors.black25,
                        offset: Offset(0.0, 4.0),
                        spreadRadius: 0.0,
                        blurRadius: 4.0,
                      ),
                    ]
                  : null,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextTheme.manrope14Medium.copyWith(
                color: isSelected ? AppTheme.primaryColor : AppTheme.grassColor,
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTileTap({
    required BuildContext context,
    required bool isSelected,
  }) {
    if (!isSelected) {
      BlocProvider.of<WithdrawAmountBloc>(context).add(
        const ChangeWithdrawAmountMethodTypeRequest(),
      );
    }
  }
}
