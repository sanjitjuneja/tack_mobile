import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';

import 'package:tacks/src/add_edit_tack/bloc/add_edit_tack_bloc.dart';

class GroupSection extends StatelessWidget {
  final AddEditTackState state;

  const GroupSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (_, GlobalState globalState) {
        return OpacityOnTapContainer(
          onTap: globalState.canPickOtherGroup && state.isAdd
              ? () => _onGroupContainerPressed(context)
              : null,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppTheme.successColor),
            ),
            child: Row(
              children: <Widget>[
                AppNetworkImageWidget(state.groupData.group?.imageUrl),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    state.groupData.hasData
                        ? state.groupData.group!.name
                        : FlutterI18n.translate(
                            context,
                            'general.noGroupSelectedSubtitle',
                          ),
                    style: AppTextTheme.manrope18Regular
                        .copyWith(color: AppTheme.textPrimaryColor),
                  ),
                ),
                if (state.isAdd && globalState.canPickOtherGroup) ...<Widget>[
                  const SizedBox(width: 8),
                  AppIconsTheme.chevronRight(
                      color: AppTheme.iconSecondaryColor),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _onGroupContainerPressed(BuildContext context) {
    BlocProvider.of<AddEditTackBloc>(context).add(const GroupChange());
  }
}
