library app_dialog;

import 'dart:math';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation/navigation.dart';

part 'src/models/alert.dart';
part 'src/models/destructive_alert.dart';
part 'src/models/error_alert.dart';
part 'src/models/request_alert.dart';
part 'src/models/success_alert.dart';

part 'src/widgets/alert_dialog/app_alert_dialog_widget.dart';
part 'src/widgets/alert_dialog/app_full_alert_dialog_form.dart';
part 'src/widgets/alert_dialog/app_full_alert_dialog_screen.dart';
part 'src/widgets/destructive_dialog/destructive_dialog_widget.dart';
part 'src/widgets/progress_dialog/circular_progress_bar.dart';
part 'src/widgets/progress_dialog/circular_progress_bar_painter.dart';
part 'src/widgets/progress_dialog/progress_indicator.dart';
part 'src/widgets/progress_dialog/progress_indicator_size.dart';

part 'src/widgets/base_dialog_widget.dart';
part 'src/widgets/dialog_text_widget.dart';
part 'src/widgets/message_widget.dart';
part 'src/widgets/title_widget.dart';

part 'src/alert_dialog_page.dart';
part 'src/alert_type_to_view_extension.dart';
part 'src/destructive_dialog_page.dart';
part 'src/progress_dialog_page.dart';
part 'src/alert_localization_mapper.dart';
part 'src/typedefs.dart';
