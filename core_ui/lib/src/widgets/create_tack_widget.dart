import 'package:core/localization/app_localization.dart';
import 'package:domain/models/create_tack_model.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class CreateTackWidget extends StatelessWidget {
  final Function onChangeTab;
  final bool isPopularTabOpened;
  final List<CreateTackModel> tacks;

  const CreateTackWidget({
    required this.tacks,
    required this.onChangeTab,
    required this.isPopularTabOpened,
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
          children: <Widget>[
            const SizedBox(height: 62),
            PageAppBar(
              text: AppLocalizations.of(context).value('createTack.title'),
            ),
            const SizedBox(height: 9),
            Text(
              AppLocalizations.of(context).value(
                'createTack.description',
              ),
              style: AppTextTheme.manrope13Medium.copyWith(
                color: AppTheme.descriptionTextColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SearchFieldWidget(
                  query: '',
                  onSearch: (String value) {},
                  onCrossPressed: () {},
                  onFilterPressed: () {},
                  hintText: AppLocalizations.of(context).value(
                    'searchField.createTack',
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
              onToggleCallback: (value) {
                onChangeTab();
              },
              activeColor: AppTheme.grassColor,
              inactiveColor: AppTheme.positiveColor,
            ),
            const SizedBox(height: 11),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 11),
                itemBuilder: (BuildContext context, int index) {
                  return CreateTackListWidget(
                    onEditPressed: () {},
                    tack: tacks[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 12);
                },
                itemCount: tacks.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
