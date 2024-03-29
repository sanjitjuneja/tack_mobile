library tacks;

import 'package:core/core.dart';
import 'package:domain/use_case.dart';

import '../global/global.dart';
import '../groups/groups.dart';
import '../web_sockets/web_sockets.dart';

part 'models/group_tack.dart';
part 'models/offer.dart';
part 'models/offer_type.dart';
part 'models/runner_tack.dart';
part 'models/tack.dart';
part 'models/tack_status.dart';
part 'models/tack_user.dart';
part 'models/tack_user_contacts.dart';
part 'models/template_tack.dart';

part 'payloads/accept_offer_payload.dart';
part 'payloads/cancel_offer_payload.dart';
part 'payloads/cancel_tack_payload.dart';
part 'payloads/complete_tack_payload.dart';
part 'payloads/create_tack_payload.dart';
part 'payloads/fetch_completed_tacks_payload.dart';
part 'payloads/fetch_created_tacks_payload.dart';
part 'payloads/fetch_runner_tacks_payload.dart';
part 'payloads/fetch_tacker_tacks_payload.dart';
part 'payloads/fetch_tack_payload.dart';
part 'payloads/fetch_group_popular_tacks_payload.dart';
part 'payloads/fetch_group_tacks_payload.dart';
part 'payloads/fetch_has_running_tack_payload.dart';
part 'payloads/make_offer_payload.dart';
part 'payloads/fetch_nearby_popular_tacks_payload.dart';
part 'payloads/rate_tack_payload.dart';
part 'payloads/start_tack_payload.dart';
part 'payloads/fetch_tack_offers_payload.dart';
part 'payloads/update_tack_payload.dart';

part 'repositories/tacks_repository.dart';

part 'use_cases/accept_offer_use_case.dart';
part 'use_cases/cancel_offer_use_case.dart';
part 'use_cases/cancel_tack_runner_use_case.dart';
part 'use_cases/cancel_tack_tacker_use_case.dart';
part 'use_cases/complete_tack_runner_use_case.dart';
part 'use_cases/complete_tack_tacker_use_case.dart';
part 'use_cases/create_tack_use_case.dart';
part 'use_cases/edit_tack_use_case.dart';
part 'use_cases/fetch_completed_tacks_use_case.dart';
part 'use_cases/fetch_created_tacks_use_case.dart';
part 'use_cases/fetch_group_popular_tacks_use_case.dart';
part 'use_cases/fetch_group_tacks.dart';
part 'use_cases/fetch_has_running_tack_use_case.dart';
part 'use_cases/fetch_nearby_popular_tacks_use_case.dart';
part 'use_cases/fetch_runner_tacks_use_case.dart';
part 'use_cases/fetch_tack_offers_use_case.dart';
part 'use_cases/fetch_tack_use_case.dart';
part 'use_cases/fetch_tacker_tacks_use_case.dart';
part 'use_cases/make_offer_use_case.dart';
part 'use_cases/observe_cancel_tacker_tack_runner_intent_use_case.dart';
part 'use_cases/observe_completed_tack_runner_intent_use_case.dart';
part 'use_cases/observe_group_tack_intent_use_case.dart';
part 'use_cases/observe_offer_intent_use_case.dart';
part 'use_cases/observe_runner_tack_intent_use_case.dart';
part 'use_cases/observe_tacker_tack_intent_use_case.dart';
part 'use_cases/rate_tack_use_case.dart';
part 'use_cases/start_tack_runner_use_case.dart';
