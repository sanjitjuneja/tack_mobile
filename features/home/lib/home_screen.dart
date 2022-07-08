import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:home/dashboard/dashboard_screen.dart';
import 'package:home/tack_creator/create_tack_screen.dart';

// TODO: remove.
/// For Test and Demo
// return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       AppCircleButton(
//                         label: 'Request alert',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 AppAlertDialog.page(
//                                   RequestAlert(
//                                     contentKey: 'test',
//                                     title: 'Offer Sent',
//                                     message:
//                                         'We will notify you if the offer is accepted',
//                                     buttonLabel: 'View All Offers Sent',
//                                   ),
//                                   onButtonTap: () {},
//                                 ),
//                               );
//                         },
//                       ),
//                       const SizedBox(height: 6),
//                       AppCircleButton(
//                         label: 'New Group Request alert',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 AppAlertDialog.page(
//                                   RequestAlert(
//                                     contentKey: 'test',
//                                     title: 'New Group Requested...',
//                                     message:
//                                         'We will notify you via text if the new group is accepted (1-2 days)',
//                                     buttonLabel: 'Close',
//                                   ),
//                                 ),
//                               );
//                         },
//                       ),
//                       const SizedBox(height: 6),
//                       AppCircleButton(
//                         label: 'Cancelled alert',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 AppAlertDialog.page(
//                                   DestructiveAlert(
//                                     contentKey: 'test',
//                                     title: 'Tack Cancelled',
//                                     buttonLabel: 'Close',
//                                   ),
//                                 ),
//                               );
//                         },
//                       ),
//                       const SizedBox(height: 6),
//                       AppCircleButton(
//                         label: 'Offer accepted alert',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 AppAlertDialog.page(
//                                   SuccessAlert(
//                                     contentKey: 'test',
//                                     title: 'Offer Accepted',
//                                     message:
//                                         'Need someone to Re-string my Fender Strat',
//                                     buttonLabel: 'Begin Tack',
//                                   ),
//                                 ),
//                               );
//                         },
//                       ),
//                       const SizedBox(height: 6),
//                       AppCircleButton(
//                         label: 'You now in group alert',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 AppAlertDialog.page(
//                                   SuccessAlert(
//                                     contentKey: 'test',
//                                     message:
//                                         'You are now a member of\n <highlight-colored>Calllaway Group</highlight-colored>',
//                                     buttonLabel: 'Close',
//                                   ),
//                                 ),
//                               );
//                         },
//                       ),
//                       const SizedBox(height: 6),
//                       AppCircleButton(
//                         label: 'Destructive dialog without title',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 DestructiveDialog.page(
//                                   DestructiveAlert(
//                                     contentKey: 'test',
//                                     message:
//                                         'Are you sure want to <colored>Cancel</colored>\n <highlight>Need Laundry and Dishes...</highlight>',
//                                   ),
//                                 ),
//                               );
//                         },
//                       ),
//                       const SizedBox(height: 6),
//                       AppCircleButton(
//                         label: 'Destructive dialog with title',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 DestructiveDialog.page(
//                                   DestructiveAlert(
//                                     contentKey: 'test',
//                                     title: 'Your Tack Score Will Decrease',
//                                     message:
//                                         'Are you sure want to <colored>Cancel</colored>\n <highlight>Need Laundry and Dishes...</highlight>',
//                                   ),
//                                 ),
//                               );
//                         },
//                       ),
//                       const SizedBox(height: 6),
//                       AppCircleButton(
//                         label: 'Delete account dialog',
//                         onTap: () {
//                           appLocator.get<AppRouterDelegate>().push(
//                                 DestructiveDialog.page(
//                                   DestructiveAlert(
//                                     contentKey: 'test',
//                                     message:
//                                         'Are you sure you want to \n<colored>Delete Your Account</colored>?',
//                                   ),
//                                 ),
//                               );
//                         },
//                       ),
//
//                       const SizedBox(height: 10),
//                       AppCircleButton(
//                         label: 'test',
//                         onTap: () {
//                           BlocProvider.of<GroupBloc>(context)
//                               .add(const ChangeGroup());
//                         },
//                       ),
//                     ],
//                   );
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppImagesTheme.dashboard,
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppImagesTheme.addTab,
              ),
            ),
          ],
          backgroundColor: AppTheme.positiveColor,
          activeColor: AppTheme.grassColor,
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return const CupertinoPageScaffold(
                    backgroundColor: AppTheme.backgroundColor,
                    child: DashboardScreen(),
                  );
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return const CupertinoPageScaffold(
                    backgroundColor: AppTheme.backgroundColor,
                    child: CreateTackScreen(),
                  );
                },
              );

            default:
              return const CupertinoTabView();
          }
        },
      ),
    );
  }
}
