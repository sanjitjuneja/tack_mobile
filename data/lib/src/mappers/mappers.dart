library mappers;

import 'package:data/src/entities/entities.dart';
import 'package:data/src/entities/global/global.dart';
import 'package:domain/domain.dart' as domain;

part 'global/pagination_mapper.dart';

part 'groups/group_invitation_mapper.dart';
part 'groups/group_invite_link_mapper.dart';
part 'groups/group_invite_mapper.dart';
part 'groups/group_mapper.dart';

part 'phone_verification/sms_verification_mapper.dart';
part 'phone_verification/phone_verification_mapper.dart';

part 'tacks/offer_mapper.dart';
part 'tacks/offer_type_mapper.dart';
part 'tacks/runner_tack_mapper.dart';
part 'tacks/tack_mapper.dart';
part 'tacks/tack_status_mapper.dart';
part 'tacks/tack_user_contacts_mapper.dart';
part 'tacks/tack_user_mapper.dart';
part 'tacks/template_tack_mapper.dart';

part 'user/user_bank_account_mapper.dart';
part 'user/user_mapper.dart';

part 'payment/plaid_mapper.dart';
part 'payment/bank_account_mapper.dart';
part 'payment/payment_setup_intent_mapper.dart';

part 'base_mapper.dart';

part 'mapper_factory.dart';
