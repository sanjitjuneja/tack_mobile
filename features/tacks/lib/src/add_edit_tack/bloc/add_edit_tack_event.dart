part of 'add_edit_tack_bloc.dart';

abstract class AddEditTackEvent {
  const AddEditTackEvent();
}

class CreateTackRequest extends AddEditTackEvent {
  const CreateTackRequest();
}

class EditTackRequest extends AddEditTackEvent {
  const EditTackRequest();
}

class ClearAction extends AddEditTackEvent {
  const ClearAction();
}

class GroupChange extends AddEditTackEvent {
  const GroupChange();
}

class TitleChange extends AddEditTackEvent {
  final String title;

  const TitleChange(this.title);
}

class PriceChange extends AddEditTackEvent {
  final String price;

  const PriceChange(this.price);
}

class DescriptionChange extends AddEditTackEvent {
  final String description;

  const DescriptionChange(this.description);
}

class TimeEstimationChange extends AddEditTackEvent {
  final String? timeEstimation;

  const TimeEstimationChange(this.timeEstimation);
}

class TimeEstimationInChange extends AddEditTackEvent {
  final TimeEstimationIn estimationIn;

  const TimeEstimationInChange(this.estimationIn);
}

class CounterOfferOptionChange extends AddEditTackEvent {
  final bool allowCounterOffer;

  const CounterOfferOptionChange(this.allowCounterOffer);
}
