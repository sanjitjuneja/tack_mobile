import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

import 'option_tile.dart';
import '../../bloc/tack_options_bloc.dart';

class CustomerSupportTile extends StatelessWidget {
  const CustomerSupportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionTile(
      titleKey: 'tackOptionsDrawer.contactCustomerSupport',
      icon: AppIconsTheme.support,
      onTap: _onTilePressed,
    );
  }

  void _onTilePressed(BuildContext context) {
    BlocProvider.of<TackOptionsBloc>(context).add(const OpenCustomerSupport());
  }
}
