import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import 'package:create_tack/src/bloc/create_tack_bloc.dart';
import 'package:create_tack/src/ui/create_tack_form.dart';

class CreateTackScreen extends StatelessWidget {
  const CreateTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTackBloc>(
      create: (_) => CreateTackBloc(
        globalBloc: BlocProvider.of<GlobalBloc>(context),
        appRouter: appLocator.get<AppRouterDelegate>(),
        getNearbyPopularTacksUseCase:
            appLocator.get<GetNearbyPopularTacksUseCase>(),
        getGroupPopularTacksUseCase:
            appLocator.get<GetGroupPopularTacksUseCase>(),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          automaticallyImplyLeading: false,
          withMenu: true,
          middle: BlocBuilder<GlobalBloc, GlobalState>(
            builder: (_, GlobalState state) {
              return Align(
                alignment: Alignment.centerLeft,
                child: PageHeaderWithGroupWidget(
                  titleKey: 'createTackScreen.title',
                  subtitleKey: 'general.noGroupSelectedSubtitle',
                  group: state.currentGroup,
                  withFeedback: state.canPickOtherGroup,
                  onTap: state.canPickOtherGroup
                      ? () => _onHeaderTap(context)
                      : null,
                ),
              );
            },
          ),
        ),
        child: const SafeArea(
          child: CreateTackForm(),
        ),
      ),
    );
  }

  void _onHeaderTap(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context).add(const ChangeGroup());
  }
}
