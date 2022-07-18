import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTackScreen extends StatelessWidget {
  const CreateTackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
          automaticallyImplyLeading: false,
          middle: Align(
            alignment: Alignment.centerLeft,
            child: GroupUserHeaderWidget(
              user: const UserModel(
                imageUrl: '',
                name: 'Skom-42',
              ),
              group: const Group(id: 2, name: 'Callaway Group'),
              onTap: () => () {},
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 10),
              onPressed: () {},
              child: AppIconsTheme.menu(
                color: AppTheme.iconPrimaryColor,
              ),
            ),
          ],
        ),
        child: SafeArea(
          child: KeyboardDismissible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 19),
              child: Column(
                children: <Widget>[
                  Text(
                    'Fill in the following info to create a custom Tack within your group (Callaway Group)',
                    style: AppTextTheme.manrope13Medium.copyWith(
                      color: AppTheme.textDescriptionColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Text(
                        'Title ',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      Text(
                        '*',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.errorColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppTextField(placeholder: 'Title'),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Text(
                        'Price  ',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      Text(
                        '*',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.errorColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppTextField(placeholder: 'Price'),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Text(
                        'Description ',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      Text(
                        '*',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.errorColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    placeholder: 'Type here...',
                    minLines: 4,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Text(
                        'Time Estimation ',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.accentColor,
                        ),
                      ),
                      Text(
                        '*',
                        style: AppTextTheme.manrope14Bold.copyWith(
                          color: AppTheme.errorColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Flexible(child: AppTextField(placeholder: '#')),
                                const SizedBox(width: 43),
                                Flexible(
                                  child: AppSegmentController(
                                    // controller: controller,
                                    tabs: <String>[
                                      'Min',
                                      'Hrs',
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  RoundedCustomButton(
                    text: 'Create',
                    backgroundColor: AppTheme.grassColor,
                    textStyle: AppTextTheme.manrope20Light.copyWith(
                      color: AppTheme.positiveColor,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
