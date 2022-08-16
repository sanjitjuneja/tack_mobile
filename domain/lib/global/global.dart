library global;

import 'package:core/core.dart';
import 'package:domain/authorization/authorization.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';
import 'package:splash/splash_feature.dart';

part 'models/deeplink_destination.dart';
part 'models/deeplink_intent.dart';
part 'models/pagination_model.dart';

part 'payloads/create_deeplink_payload.dart';

part 'repositories/deeplink_repository.dart';

part 'use_cases/create_deeplink_use_case.dart';
part 'use_cases/get_last_deeplink_use_case.dart';
part 'use_cases/log_out_use_case.dart';
part 'use_cases/observe_deeplink_use_case.dart';
part 'use_cases/reset_last_deeplink_use_case.dart';
