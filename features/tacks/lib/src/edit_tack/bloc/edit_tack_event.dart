part of 'edit_tack_bloc.dart';

abstract class EditTackEvent {
  const EditTackEvent();
}

class EditTackRequest extends EditTackEvent {
  const EditTackRequest();
}

class TitleChange extends EditTackEvent {
  final String title;

  const TitleChange(this.title);
}

class PriceChange extends EditTackEvent {
  final String price;

  const PriceChange(this.price);
}

class DescriptionChange extends EditTackEvent {
  final String description;

  const DescriptionChange(this.description);
}

class TimeEstimationChange extends EditTackEvent {
  final String? timeEstimation;

  const TimeEstimationChange(this.timeEstimation);
}

class TimeEstimationInChange extends EditTackEvent {
  final TimeEstimationIn estimationIn;

  const TimeEstimationInChange(this.estimationIn);
}

class CounterOfferOptionChange extends EditTackEvent {
  final bool allowCounterOffer;

  const CounterOfferOptionChange(this.allowCounterOffer);
}
