part of 'add_edit_tack_bloc.dart';

class AddEditTackState {
  final Tack? tack;
  final bool isAdd;
  final GroupData groupData;
  final TitleData titleData;
  final PriceData priceData;
  final DescriptionData descriptionData;
  final TimeEstimationData timeEstimationData;
  final CounterOfferData counterOfferData;

  bool get isReadyToProceed {
    return <bool>[
      groupData.isValid,
      titleData.isValid,
      priceData.isValid,
      descriptionData.isValid,
      timeEstimationData.isValid,
      counterOfferData.isValid,
    ].every((bool element) => element == true);
  }

  bool get isAnyDataChanged {
    return <bool>[
      titleData.isDataChanged(tack?.title),
      priceData.isDataChanged(tack?.price),
      descriptionData.isDataChanged(tack?.description),
      timeEstimationData.isDataChanged(tack?.estimatedTime?.inSeconds),
      counterOfferData.isDataChanged(tack?.allowCounterOffers),
    ].any((bool element) => element == true);
  }

  const AddEditTackState({
    required this.tack,
    required this.isAdd,
    required this.groupData,
    required this.titleData,
    required this.priceData,
    required this.descriptionData,
    required this.timeEstimationData,
    required this.counterOfferData,
  });

  factory AddEditTackState.fromTack(
    Group? group,
    TemplateTack? templateTack,
    Tack? tack,
    bool isAdd,
  ) {
    return AddEditTackState(
      tack: tack,
      isAdd: isAdd,
      groupData: GroupData(
        group: group,
        isRequired: true,
      ),
      titleData: TitleData(
        maxLength: 100,
        isRequired: true,
        title: templateTack?.title ?? tack?.title,
      ),
      priceData: PriceData(
        maxValue: 1000,
        isRequired: true,
        price: (templateTack?.price ?? tack?.price)?.toStringAsFixed(2),
      ),
      descriptionData: DescriptionData(
        maxWords: 30,
        isRequired: true,
        description: templateTack?.description ?? tack?.description,
      ),
      timeEstimationData: TimeEstimationData.fromTime(
        maxValues: <TimeEstimationIn, num>{
          TimeEstimationIn.min: 60,
          TimeEstimationIn.hour: 24,
        },
        isRequired: false,
        timeInSeconds: templateTack?.estimatedTime?.inSeconds ??
            tack?.estimatedTime?.inSeconds,
      ),
      counterOfferData: CounterOfferData(
        isRequired: false,
        allow: templateTack?.allowCounterOffers ?? tack?.allowCounterOffers,
      ),
    );
  }

  AddEditTackState copyWith({
    Group? group,
    String? title,
    String? price,
    String? description,
    String? timeEstimation,
    TimeEstimationIn? timeEstimationIn,
    bool? allowCounterOffer,
    bool? isValidationEnabled,
  }) {
    return AddEditTackState(
      tack: tack,
      isAdd: isAdd,
      groupData: groupData.copyWith(group: group),
      titleData: titleData.copyWith(
        title: title,
        isValidationEnabled: isValidationEnabled,
      ),
      priceData: priceData.copyWith(
        price: price,
        isValidationEnabled: isValidationEnabled,
      ),
      descriptionData: descriptionData.copyWith(
        description: description,
        isValidationEnabled: isValidationEnabled,
      ),
      timeEstimationData: timeEstimationData.copyWith(
        timeEstimation: timeEstimation,
        timeEstimationIn: timeEstimationIn,
      ),
      counterOfferData: counterOfferData.copyWith(allow: allowCounterOffer),
    );
  }

  AddEditTackState clear() {
    return AddEditTackState(
      tack: tack,
      isAdd: isAdd,
      groupData: groupData.empty(),
      titleData: titleData.empty(),
      priceData: priceData.empty(),
      descriptionData: descriptionData.empty(),
      timeEstimationData: timeEstimationData.empty(),
      counterOfferData: counterOfferData.empty(),
    );
  }
}
