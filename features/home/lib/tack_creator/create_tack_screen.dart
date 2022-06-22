import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import 'bloc/create_tack_bloc.dart';
import 'bloc/create_tack_event.dart';
import 'bloc/create_tack_state.dart';

class CreateTackScreen extends StatelessWidget {
  const CreateTackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTackBloc>(
      create: (BuildContext context) => CreateTackBloc(),
      child: BlocBuilder<CreateTackBloc, CreateTackState>(
        builder: (BuildContext context, CreateTackState state) {
          if (state is CreateTackLoading) {
            return const SizedBox.shrink();
          } else if (state is CreateTackContent) {
            return CreateTackWidget(
              tacks: state.tacks,
              isPopularTabOpened: state.isPopularTabOpened,
              onChangeTab: () {
                BlocProvider.of<CreateTackBloc>(context).add(
                  ChangeRoom(),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
