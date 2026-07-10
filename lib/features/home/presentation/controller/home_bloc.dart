import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';
import 'package:ghosno/features/home/domain/usecases/add_to_cart_uc.dart';
import 'package:ghosno/features/home/domain/usecases/buy_uc.dart';
import 'package:ghosno/features/home/domain/usecases/get_products_uc.dart';

import '../../../../core/utils/enums.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUc getProductsUc;
  final AddToCartUc addToCartUc;
  final BuyUc buyUc;
  HomeBloc(this.getProductsUc, this.addToCartUc, this.buyUc)
      : super(HomeState()) {
    on<GetProductsEvent>(_getProduct);
    on<AddToCartEvent>(_addToCart);
    on<BuyEvent>(_buy);
  }

  FutureOr<void> _getProduct(
      GetProductsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productsRequestState: RequestState.loading));
    final result = await getProductsUc.call(event.noParameters);
    result.fold(
        (l) => emit(state.copyWith(
            productsRequestState: RequestState.error,
            productErrorMessage: l.errorMessageModel.statusMessage)),
        (r) => emit(state.copyWith(
            productsRequestState: RequestState.loaded,
            products: r,
            productErrorMessage: '')));
  }

  FutureOr<void> _addToCart(
      AddToCartEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(addToCartRequestState: RequestState.loading));
    final result = await addToCartUc.call(event.addToCartParameters);
    result.fold(
        (l) => emit(state.copyWith(
            addToCartRequestState: RequestState.error,
            productErrorMessage: l.errorMessageModel.statusMessage)),
        (r) => emit(state.copyWith(
            addToCartRequestState: RequestState.loaded,
            productErrorMessage: '')));
  }

  FutureOr<void> _buy(BuyEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(buyRequestState: RequestState.loading));
    final result = await buyUc.call(event.buyParameters);
    result.fold(
        (l) => emit(state.copyWith(
            buyRequestState: RequestState.error,
            productErrorMessage: l.errorMessageModel.statusMessage)),
        (r) => emit(state.copyWith(
            buyRequestState: RequestState.loaded, productErrorMessage: '')));
  }
}
