library tacks;

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';

part 'models/offer.dart';
part 'models/offer_type.dart';
part 'models/runner_tack.dart';
part 'models/tack.dart';
part 'models/tack_status.dart';
part 'models/tack_user.dart';
part 'models/tack_user_contacts.dart';
part 'models/template_tack.dart';

part 'payloads/create_tack_payload.dart';
part 'payloads/group_popular_tacks_payload.dart';
part 'payloads/group_tacks_payload.dart';
part 'payloads/make_offer_payload.dart';
part 'payloads/nearby_popular_tacks_payload.dart';
part 'payloads/rate_tack_payload.dart';
part 'payloads/update_tack_payload.dart';

part 'repositories/tacks_repository.dart';

part 'use_cases/create_tack_use_case.dart';
part 'use_cases/edit_tack_use_case.dart';
part 'use_cases/get_group_popular_tacks_use_case.dart';
part 'use_cases/get_group_tacks.dart';
part 'use_cases/get_nearby_popular_tacks_use_case.dart';
part 'use_cases/get_runner_tacks_use_case.dart';
part 'use_cases/get_tacker_tacks_use_case.dart';
part 'use_cases/make_offer_use_case.dart';
part 'use_cases/rate_tack_use_case.dart';
