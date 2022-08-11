import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/group_details/bloc/group_details_bloc.dart';
import 'package:groups/src/group_details/ui/widgets/group_info/group_info_footer.dart';
import 'package:groups/src/group_details/ui/widgets/group_info/group_info_header.dart';

class GroupInfoWidget extends StatelessWidget {
  const GroupInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsBloc, GroupDetailsState>(
      builder: (_, GroupDetailsState state) {
        return ContainerWithSeparator(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          dividerPadding: const EdgeInsets.symmetric(vertical: 14.0),
          header: GroupInfoHeader(group: state.group),
          footer: GroupInfoFooter(group: state.group),
        );
      },
    );
  }
}
