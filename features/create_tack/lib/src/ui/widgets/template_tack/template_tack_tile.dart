import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:create_tack/src/bloc/create_tack_bloc.dart';
import 'package:create_tack/src/ui/widgets/template_tack/template_tack_footer.dart';
import 'package:create_tack/src/ui/widgets/template_tack/template_tack_header.dart';

class TemplateTackTile extends StatelessWidget {
  final TemplateTack tack;

  const TemplateTackTile({
    super.key,
    required this.tack,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: () => _onTap(context),
      child: ContainerWithSeparator(
        header: TemplateTackHeader(tack: tack),
        footer: TemplateTackFooter(
          tack: tack,
          onActionPressed: _onTap,
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    BlocProvider.of<CreateTackBloc>(context).add(CreateTackAction(tack: tack));
  }
}
