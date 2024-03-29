library groups_entities;

import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

import '../../helpers/entity_helper/entities_helpers.dart';
import '../global/global.dart';

part 'entities/group_details_entity.dart';
part 'entities/group_entity.dart';
part 'entities/group_invitation_entity.dart';
part 'entities/group_invite_entity.dart';
part 'entities/group_invite_link_entity.dart';

part 'requests/accept_group_invitation_request.dart';
part 'requests/create_group_request.dart';
part 'requests/decline_group_invitation_request.dart';
part 'requests/fetch_group_invitations_request.dart';
part 'requests/fetch_group_invite_link_request.dart';
part 'requests/fetch_group_invite_request.dart';
part 'requests/fetch_group_members_request.dart';
part 'requests/fetch_group_request.dart';
part 'requests/fetch_groups_request.dart';
part 'requests/leave_group_request.dart';
part 'requests/mute_group_request.dart';
part 'requests/select_group_request.dart';
part 'requests/un_mute_group_request.dart';

part 'groups.g.dart';
