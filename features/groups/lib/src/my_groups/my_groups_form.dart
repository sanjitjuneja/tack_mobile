import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'bloc/groups_bloc.dart';
import 'bloc/groups_event.dart';
import 'bloc/groups_state.dart';

class MyGroupsForm extends StatelessWidget {
  const MyGroupsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(
      builder: (_, GroupsState state) {
        return Column(
          children: <Widget>[
            Expanded(
              child: CupertinoScrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'My Groups',
                        style: AppTextTheme.manrope24SemiBold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Select one of the following groups to switch your current app view',
                        style: AppTextTheme.manrope13Medium.copyWith(
                          color: AppTheme.textDescriptionColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return MyGroupListWidget(
                            groupName: 'Callaway Group',
                            onOpenDetails: () => _onOpenGroupsDetails(context),
                            onInviteMembers: () {},
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 12);
                        },
                        itemCount: 3,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: AppButton(
                              labelKey: 'My Invintations',
                              onTap: () => _onOpenInvitations(context),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppButton(
                              labelKey: 'Create Group',
                              type: ButtonType.secondary,
                              onTap: () => _onCreateGroup(context),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onOpenInvitations(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(
      OpenMyInvitations(),
    );
  }

  void _onCreateGroup(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(
      OnCreateGroup(),
    );
  }

  void _onOpenGroupsDetails(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(
      OpenGroupDetails(),
    );
  }
}
