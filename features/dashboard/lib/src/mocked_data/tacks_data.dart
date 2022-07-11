import 'package:domain/domain.dart';

final List<TackModel> tacks = List<TackModel>.filled(
  10,
  const TackModel(
    name: 'Pick Up My Clothes from Dry Cleaning',
    fee: 15.0,
    estimatedTime: Duration(minutes: 15),
    user: UserModel(
      name: 'Alan Cooper',
      imageUrl: '',
    ),
    description:
        'Pick up my dry cleaning and deliver to 31 Pascal Dr in Austin, TX 78705. We will meet you.',
  ),
);
