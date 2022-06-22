import 'package:core/localization/app_localization.dart';
import 'package:domain/models/tack_list_model.dart';
import 'package:domain/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class DashboardWidget extends StatelessWidget {
  final UserModel user;
  final Function onTabChanged;
  final List<TackListModel> tacks;

  const DashboardWidget({
    required this.user,
    required this.tacks,
    required this.onTabChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 49),
            PageAppBar(
              avatar: AppImagesTheme.avatar,
            ),
            const SizedBox(height: 16),
            Text(
              '${AppLocalizations.of(context).value('dashboard.greetings')}, ${user.name}',
              style: AppTextTheme.manrope18Light.copyWith(
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              AppLocalizations.of(context).value(
                'dashboard.title',
              ),
              style: AppTextTheme.manrope24SemiBold.copyWith(
                color: AppTheme.accentColor,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                SearchFieldWidget(
                  query: '',
                  onCrossPressed: () {},
                  onFilterPressed: () {},
                  onSearch: (String value) {},
                  hintText: AppLocalizations.of(context).value(
                    'searchField.dashboard',
                  ),
                ),
                const SizedBox(width: 10),
                ImagedButton(
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            AnimatedToggle(
              values: <String>[
                AppLocalizations.of(context).value('toggle.public'),
                AppLocalizations.of(context).value('toggle.privat'),
              ],
              activeColor: AppTheme.grassColor,
              inactiveColor: AppTheme.positiveColor,
              onToggleCallback: (value) {
                onTabChanged();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (BuildContext context, int index) {
                  return TackListWidget(
                    tack: tacks[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 12);
                },
                itemCount: tacks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
