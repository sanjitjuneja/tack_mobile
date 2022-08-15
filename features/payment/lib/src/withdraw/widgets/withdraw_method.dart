import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/withdraw_method_type.dart';
import '../bloc/withdraw_bloc.dart';

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
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (withdrawMethodType != state.withdrawMethodType) {
              BlocProvider.of<WithdrawBloc>(context).add(
                const ChangeWithdrawMethodTypeRequest(),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: withdrawMethodType == state.withdrawMethodType
                  ? AppTheme.grassColor
                  : AppTheme.primaryColor,
              border: Border.all(
                color: withdrawMethodType == state.withdrawMethodType
                    ? AppTheme.primaryColor
                    : AppTheme.grassColor,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextTheme.manrope14Medium.copyWith(
                color: withdrawMethodType == state.withdrawMethodType
                    ? AppTheme.primaryColor
                    : AppTheme.grassColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
