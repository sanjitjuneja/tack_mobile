import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TackHeaderWidget extends StatelessWidget {
  final String name;
  final double fee;

  const TackHeaderWidget({
    super.key,
    required this.name,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            name,
            style: AppTextTheme.manrope16SemiBold
                .copyWith(color: AppTheme.textPrimaryColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          CurrencyUtility.dollarFormat.format(fee),
          style: AppTextTheme.manrope24Bold
              .copyWith(color: AppTheme.textSecondaryColor),
        ),
      ],
    );
  }
}
