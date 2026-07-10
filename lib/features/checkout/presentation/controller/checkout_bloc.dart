import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';
import 'package:ghosno/features/checkout/domain/usecases/calculate_uc.dart';
import 'package:ghosno/features/checkout/domain/usecases/get_cities_uc.dart';

import '../../../../core/utils/enums.dart';
import '../../data/models/city_model.dart';
import '../../domain/usecases/create_order_uc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final GetCitiesUc getCitiesUc;
  final CalculateUc calculateUc;
  final CreateOrderUc createOrderUc;
  CheckoutBloc(this.getCitiesUc, this.calculateUc, this.createOrderUc)
      : super(CheckoutState()) {
    on<GetCitiesEvent>(_getCities);
    on<CalculateEvent>(_calculate);
    on<CreateOrderEvent>(_createOrder);
  }

  FutureOr<void> _getCities(
      GetCitiesEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(
        getCitiesRequestState: RequestState.loading, checkoutErrorMessage: ''));
    final result = await getCitiesUc.call(event.noParameters);
    result.fold(
        (l) => emit(state.copyWith(
            getCitiesRequestState: RequestState.error,
            checkoutErrorMessage: '')),
        (r) => emit(state.copyWith(
            getCitiesRequestState: RequestState.loaded,
            cities: r,
            checkoutErrorMessage: '')));
  }

  FutureOr<void> _calculate(
      CalculateEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(
      calculateRequestState: RequestState.loading,
      checkoutErrorMessage: '',
    ));
    final result = await calculateUc.call(event.calculateParameters);
    result.fold(
        (l) => emit(state.copyWith(
            calculateRequestState: RequestState.error,
            checkoutErrorMessage: l.errorMessageModel.statusMessage)),
        (r) => emit(state.copyWith(
            calculateRequestState: RequestState.loaded,
            calculateResultModel: r,
            citySelectedID: event.calculateParameters.cityID,
            promoCode: event.calculateParameters.promoCode,
            checkoutErrorMessage: '')));
  }

  FutureOr<void> _createOrder(
      CreateOrderEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(
        createOrderRequestState: RequestState.loading,
        checkoutErrorMessage: ''));
    final result = await createOrderUc.call(event.createOrderParameters);
    result.fold(
        (l) => emit(state.copyWith(
            createOrderRequestState: RequestState.error,
            checkoutErrorMessage: '')),
        (r) => emit(state.copyWith(
            createOrderRequestState: RequestState.loaded,
            checkoutErrorMessage: '')));
  }
}
