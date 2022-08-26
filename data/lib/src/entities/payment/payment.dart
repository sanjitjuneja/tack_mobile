library payment_entities;

import 'package:json_annotation/json_annotation.dart';

part 'entities/payment_setup_intent_entity.dart';
part 'entities/plaid_entity.dart';
part 'entities/connected_bank_account_entity.dart';
part 'entities/connected_card_entity.dart';
part 'entities/connected_card_data_entity.dart';

part 'requests/add_bank_account_request.dart';
part 'requests/add_card_request.dart';
part 'requests/get_plaid_bank_accounts_request.dart';
part 'requests/get_connected_bank_accounts_request.dart';
part 'requests/get_connected_cards_request.dart';

part 'responses/get_connected_bank_accounts_response.dart';
part 'responses/get_connected_cards_response.dart';

part 'payment.g.dart';
