part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final List<CityModel> cities;
  final CalculateResultModel calculateResultModel;
  final String checkoutErrorMessage;
  final int? citySelectedID;
  final String? promoCode;
  final RequestState calculateRequestState;
  final RequestState getCitiesRequestState;
  final RequestState createOrderRequestState;

  const CheckoutState(
      {this.cities = const [],
      this.calculateResultModel = const CalculateResultModel(),
      this.checkoutErrorMessage = '',
      this.citySelectedID,
      this.promoCode,
      this.getCitiesRequestState = RequestState.loaded,
      this.calculateRequestState = RequestState.loaded,
      this.createOrderRequestState = RequestState.loaded});

  CheckoutState copyWith(
      {List<CityModel>? cities,
      CalculateResultModel? calculateResultModel,
      String? checkoutErrorMessage,
      int? citySelectedID,
      String? promoCode,
      RequestState? calculateRequestState,
      RequestState? getCitiesRequestState,
      RequestState? createOrderRequestState}) {
    return CheckoutState(
        cities: cities ?? this.cities,
        calculateResultModel: calculateResultModel ?? this.calculateResultModel,
        checkoutErrorMessage: checkoutErrorMessage ?? this.checkoutErrorMessage,
        citySelectedID: citySelectedID ?? this.citySelectedID,
        promoCode: promoCode ?? this.promoCode,
        calculateRequestState:
            calculateRequestState ?? this.calculateRequestState,
        getCitiesRequestState:
            getCitiesRequestState ?? this.getCitiesRequestState,
        createOrderRequestState:
            createOrderRequestState ?? this.createOrderRequestState);
  }

  @override
  List<Object> get props => [
        cities,
        calculateResultModel,
        checkoutErrorMessage,
        calculateRequestState,
        getCitiesRequestState,
        createOrderRequestState
      ];
}
