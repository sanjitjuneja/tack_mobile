library groups;

import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/tacks/tacks.dart';
import 'package:domain/use_case.dart';

import '../global/global.dart';

part 'models/group.dart';
part 'models/group_details.dart';
part 'models/group_invitation.dart';
part 'models/group_invite.dart';
part 'models/group_invite_link.dart';

part 'payloads/accept_group_invitation_payload.dart';
part 'payloads/create_group_payload.dart';
part 'payloads/decline_group_invitation_payload.dart';
part 'payloads/fetch_group_invitations_payload.dart';
part 'payloads/fetch_group_invite_link_payload.dart';
part 'payloads/fetch_group_invite_payload.dart';
part 'payloads/fetch_group_members_payload.dart';
part 'payloads/fetch_group_payload.dart';
part 'payloads/fetch_groups_payload.dart';
part 'payloads/leave_group_payload.dart';
part 'payloads/mute_group_payload.dart';
part 'payloads/select_group_payload.dart';
part 'payloads/un_mute_group_payload.dart';

part 'repositories/groups_repository.dart';

part 'use_cases/accept_group_invitation_use_case.dart';
part 'use_cases/create_group_use_case.dart';
part 'use_cases/decline_group_invitation_use_case.dart';
part 'use_cases/get_current_group_use_case.dart';
part 'use_cases/fetch_group_invite_use_case.dart';
part 'use_cases/get_groups_use_case.dart';
part 'use_cases/leave_group_use_case.dart';
part 'use_cases/fetch_group_invitations_use_case.dart';
part 'use_cases/fetch_group_invite_link.dart';
part 'use_cases/fetch_group_members_use_case.dart';
part 'use_cases/fetch_group_use_case.dart';
part 'use_cases/fetch_groups_use_case.dart';
part 'use_cases/mute_group_use_case.dart';
part 'use_cases/observe_current_group_use_case.dart';
part 'use_cases/observe_groups_use_case.dart';
part 'use_cases/select_group_use_case.dart';
part 'use_cases/un_mute_group_use_case.dart';
