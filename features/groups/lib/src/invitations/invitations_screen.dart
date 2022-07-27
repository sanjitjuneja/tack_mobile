import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:groups/src/invitations/bloc/invitations_bloc.dart';
import 'package:navigation/navigation.dart';

class InvitationsScreen extends StatelessWidget {
  const InvitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        withResult: false,
      ),
      child: BlocProvider<InvitationsBloc>(
          create: (_) => InvitationsBloc(
                appRouter: appLocator.get<AppRouterDelegate>(),
              ),
          child: BlocBuilder<InvitationsBloc, InvitationsState>(
            builder: (_, InvitationsState state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'My Invitations',
                        style: AppTextTheme.manrope24SemiBold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: Text(
                          'Here is a list of all Tack groups you have been invited to.',
                          style: AppTextTheme.manrope13Medium.copyWith(
                            color: AppTheme.textDescriptionColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InvitationListWidget(
                              onJoin: () => _onJoin(context),
                              onOpenDetails: () => _onOpenDetails(context),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 12);
                          },
                          itemCount: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  void _onOpenDetails(
    BuildContext context,
  ) {
    BlocProvider.of<InvitationsBloc>(context).add(
      OnOpenDetails(),
    );
  }

  void _onJoin(
    BuildContext context,
  ) {
    BlocProvider.of<InvitationsBloc>(context).add(
      OnJoinGroup(),
    );
  }
}
