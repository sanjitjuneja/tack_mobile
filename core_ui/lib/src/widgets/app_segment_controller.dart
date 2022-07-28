import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:segment_controller/segment_controller.dart';

/// EXAMPLE OF USAGE
//class TacksForm extends StatefulWidget {
//
//   const TacksForm({super.key});
//
//   @override
//   State<TacksForm> createState() => _TacksFormState();
// }
// class _TacksFormState extends State<TacksForm>  with TickerProviderStateMixin{
//   late TabController controller;
//
//   @override
//   void initState() {
//     controller = TabController(length: 2, vsync: this);
//     controller.addListener(() {
//       print(controller.index);
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const SizedBox(height: 17),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 45.0),
//             child: AppSegmentController(
//               tabs: <String>[
//                 'First Tab,
//                 'Second Tab',
//               ],
//             ),
//           ),
//           const SizedBox(height: 17),
//           Row(
//             children: [
//               const Spacer(flex: 3),
//               Flexible(
//                 child: AppSegmentController(
//                   controller: controller,
//                   tabs: <String>[
//                     'min',
//                     'hrs',
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               children: <Widget>[
//                 Container(color: Colors.red),
//                 Container(color: Colors.green),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AppSegmentController<T> extends StatelessWidget {
  final Map<T, String> tabs;
  final T? initialValue;
  final ValueChanged<T>? onChangeValue;
  final TextStyle? textStyle;
  final TabController? controller;

  const AppSegmentController({
    super.key,
    required this.tabs,
    this.initialValue,
    this.onChangeValue,
    this.textStyle,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedTabControl<T>(
      controller: controller,
      initialValue: initialValue,
      onValueChange: onChangeValue,
      height: 38,
      shape: BoxShape.circle,
      backgroundColor: AppTheme.segmentBackgroundColor,
      indicatorColor: AppTheme.segmentActiveBackgroundColor,
      shadow: BoxShadow(
        color: AppTheme.shadowColor,
        offset: const Offset(0, 4),
        blurRadius: 4,
      ),
      border: Border.all(color: AppTheme.segmentBorderColor),
      textStyle: textStyle ?? AppTextTheme.manrope18Medium,
      tabTextColor: AppTheme.segmentInactiveTabTextColor,
      selectedTabTextColor: AppTheme.segmentActiveTabTextColor,
      tabs: tabs.map(
        (key, value) => MapEntry(
          key,
          SegmentTab(
            label: value,
          ),
        ),
      ),
    );
  }
}
