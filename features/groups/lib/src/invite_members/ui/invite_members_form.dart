import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/invite_members/bloc/invite_members_bloc.dart';
import 'package:groups/src/invite_members/ui/widgets/invite_members_button.dart';
import 'package:groups/src/invite_members/ui/widgets/invite_members_divider.dart';
import 'package:groups/src/invite_members/ui/widgets/invite_members_header_widget.dart';

class InviteMembersForm extends StatelessWidget {
  const InviteMembersForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteMembersBloc, InviteMembersState>(
      builder: (_, InviteMembersState state) {
        return Column(
          children: <Widget>[
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InviteMembersHeaderWidget(group: state.group),
                    const SizedBox(height: 10),
                    if (state.isLoading) ...<Widget>[
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: AppProgressIndicator(
                          indicatorSize: ProgressIndicatorSize.medium,
                          backgroundColor: AppTheme.transparentColor,
                          indicatorColor: AppTheme.progressInterfaceDarkColor,
                        ),
                      ),
                    ] else if (state.hasError) ...<Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 40.0),
                        child: CupertinoButton(
                          onPressed: () => _onReloadButtonPressed(context),
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.refresh_rounded,
                            color: AppTheme.progressInterfaceDarkColor,
                            size: 60,
                          ),
                        ),
                      ),
                    ] else ...<Widget>[
                      Text(
                        FlutterI18n.translate(
                          context,
                          'inviteMembersScreen.description',
                        ),
                        style: AppTextTheme.manrope14SemiBold
                            .copyWith(color: AppTheme.textHeavyHintColor),
                      ),
                      const SizedBox(height: 22),
                      InviteMembersButton(
                        leading: AppIconsTheme.people,
                        trailing: AppIconsTheme.copy,
                        labelKey: 'inviteMembersScreen.copyLinkButtonLabel',
                        backgroundColor:
                            AppTheme.textFieldSecondaryBackgroundColor,
                        interfaceColor: AppTheme.textHeavyHintColor,
                        onTap: () => _onCopyButtonPressed(context),
                        content: state.inviteLink.toString(),
                      ),
                      const SizedBox(height: 14),
                      const InviteMembersDivider(),
                      const SizedBox(height: 16),
                      InviteMembersButton(
                        leading: AppIconsTheme.people,
                        trailing: AppIconsTheme.share,
                        labelKey: 'inviteMembersScreen.shareLinkButtonLabel',
                        backgroundColor: AppTheme.buttonPrimaryColor,
                        interfaceColor: AppTheme.buttonInterfacePrimaryColor,
                        onTap: () => _onShareButtonPressed(context),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            AppCircleButton(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              labelKey: 'inviteMembersScreen.doneButtonLabel',
              onTap: AppRouter.of(context).pop,
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  void _onCopyButtonPressed(BuildContext context) {
    BlocProvider.of<InviteMembersBloc>(context).add(const InviteCopyLink());
  }

  void _onShareButtonPressed(BuildContext context) {
    BlocProvider.of<InviteMembersBloc>(context).add(const InviteShareLink());
  }

  void _onReloadButtonPressed(BuildContext context) {
    BlocProvider.of<InviteMembersBloc>(context).add(const LoadLink());
  }
}
