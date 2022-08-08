part of 'add_edit_tack_bloc.dart';

class AddEditTackState {
  final Group? group;
  final Tack? tack;
  final bool isAdd;
  final TitleData titleData;
  final PriceData priceData;
  final DescriptionData descriptionData;
  final TimeEstimationData timeEstimationData;
  final CounterOfferData counterOfferData;

  bool get isReadyToProceed {
    final bool isAllValid = <bool>[
      titleData.isValid,
      priceData.isValid,
      descriptionData.isValid,
      timeEstimationData.isValid,
      counterOfferData.isValid,
    ].every((bool element) => element == true);

    if (isAdd) return isAllValid && group != null;

    return isAllValid && isAnyDataChanged;
  }

  bool get isAnyDataChanged {
    return <bool>[
      titleData.isDataChanged(tack?.title),
      priceData.isDataChanged(tack?.price),
      descriptionData.isDataChanged(tack?.description),
      timeEstimationData.isDataChanged(tack?.estimatedTime.inSeconds),
      counterOfferData.isDataChanged(tack?.allowCounterOffers),
    ].any((bool element) => element == true);
  }

  const AddEditTackState({
    required this.group,
    required this.tack,
    required this.isAdd,
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
      group: group,
      tack: tack,
      isAdd: isAdd,
      titleData: TitleData(
        maxLength: 100,
        isRequired: true,
        title: templateTack?.title ?? tack?.title,
      ),
      priceData: PriceData(
        maxValue: 1000,
        isRequired: true,
        price: templateTack?.price.toString() ?? tack?.price.toString(),
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
        isRequired: true,
        timeInSeconds: templateTack?.estimatedTime.inSeconds ??
            tack?.estimatedTime.inSeconds,
      ),
      counterOfferData: CounterOfferData(
        isRequired: true,
        allow: templateTack?.allowCounterOffers ?? tack?.allowCounterOffers,
      ),
    );
  }

  AddEditTackState copyWith({
    String? title,
    String? price,
    String? description,
    String? timeEstimation,
    TimeEstimationIn? timeEstimationIn,
    bool? allowCounterOffer,
  }) {
    return AddEditTackState(
      group: group,
      tack: tack,
      isAdd: isAdd,
      titleData: titleData.copyWith(title: title),
      priceData: priceData.copyWith(price: price),
      descriptionData: descriptionData.copyWith(description: description),
      timeEstimationData: timeEstimationData.copyWith(
        timeEstimation: timeEstimation,
        timeEstimationIn: timeEstimationIn,
      ),
      counterOfferData: counterOfferData.copyWith(allow: allowCounterOffer),
    );
  }

  AddEditTackState clear() {
    return AddEditTackState(
      group: group,
      tack: tack,
      isAdd: isAdd,
      titleData: titleData.empty(),
      priceData: priceData.empty(),
      descriptionData: descriptionData.empty(),
      timeEstimationData: timeEstimationData.empty(),
      counterOfferData: counterOfferData.empty(),
    );
  }
}
