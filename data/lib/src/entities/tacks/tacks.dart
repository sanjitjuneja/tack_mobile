library tacks_entities;

import 'package:data/src/helpers/entity_helper/entities_helpers.dart';
import 'package:data/src/entities/groups/groups.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entities/offer_entity.dart';
part 'entities/runner_tack_entity.dart';
part 'entities/tack_entity.dart';
part 'entities/tack_user_contacts_entity.dart';
part 'entities/tack_user_entity.dart';
part 'entities/template_tack_entity.dart';

part 'requests/cancel_offer_request.dart';
part 'requests/cancel_tack_request.dart';
part 'requests/complete_tack_request.dart';
part 'requests/create_tack_request.dart';
part 'requests/get_tack_offers_request.dart';
part 'requests/group_popular_tacks_request.dart';
part 'requests/group_tacks_request.dart';
part 'requests/make_offer_request.dart';
part 'requests/nearby_popular_tacks_request.dart';
part 'requests/rate_tack_request.dart';
part 'requests/runner_tacks_request.dart';
part 'requests/start_tack_request.dart';
part 'requests/tacker_tacks_request.dart';
part 'requests/update_tack_request.dart';

part 'responses/group_offers_response.dart';
part 'responses/group_popular_tacks_response.dart';
part 'responses/group_tacks_response.dart';
part 'responses/nearby_popular_tacks_response.dart';
part 'responses/runner_tacks_response.dart';
part 'responses/tacker_tacks_response.dart';

part 'tacks.g.dart';
