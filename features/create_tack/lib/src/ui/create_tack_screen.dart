import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import '../bloc/create_tack_bloc.dart';
import 'create_tack_form.dart';

class CreateTackScreen extends StatelessWidget {
  const CreateTackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTackBloc>(
      create: (_) => CreateTackBloc(
        globalBloc: BlocProvider.of<GlobalBloc>(context),
        appRouter: appLocator.get<AppRouterDelegate>(),
        fetchNearbyPopularTacksUseCase:
            appLocator.get<FetchNearbyPopularTacksUseCase>(),
        fetchGroupPopularTacksUseCase:
            appLocator.get<FetchGroupPopularTacksUseCase>(),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        resizeToAvoidBottomInset: false,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          automaticallyImplyLeading: false,
          withMenu: true,
          middle: BlocBuilder<GlobalBloc, GlobalState>(
            builder: (_, GlobalState state) {
              return Align(
                alignment: Alignment.centerLeft,
                child: PageHeaderWithGroupWidget(
                  titleKey: 'general.noGroupSelected',
                  subtitleKey: 'createTackScreen.title',
                  image: null,
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
