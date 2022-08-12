part of 'offers_bloc.dart';

class OffersState {
  final Tack tack;
  final PaginationModel<Offer> offersData;
  final bool isLoading;

  OffersState({
    required this.tack,
    this.isLoading = false,
    PaginationModel<Offer>? offersData,
  }) : offersData = offersData ?? PaginationModel<Offer>.empty();

  OffersState copyWith({
    PaginationModel<Offer>? offersData,
    bool? isLoading,
  }) {
    return OffersState(
      tack: tack,
      offersData: offersData ?? this.offersData,
      isLoading: isLoading ?? false,
    );
  }
}
