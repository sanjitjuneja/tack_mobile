library groups;

import 'dart:io';

import 'package:domain/use_case.dart';
import 'package:equatable/equatable.dart';

part 'models/group.dart';

part 'payloads/create_group_payload.dart';
part 'payloads/get_group_payload.dart';
part 'payloads/get_groups_payload.dart';
part 'payloads/select_group_payload.dart';

part 'repositories/groups_repository.dart';

part 'use_cases/create_group_use_case.dart';
part 'use_cases/get_current_group_use_case.dart';
part 'use_cases/get_groups_use_case.dart';
part 'use_cases/load_group_use_case.dart';
part 'use_cases/load_groups_use_case.dart';
part 'use_cases/observe_current_group_use_case.dart';
part 'use_cases/observe_groups_use_case.dart';
part 'use_cases/select_group_use_case.dart';
