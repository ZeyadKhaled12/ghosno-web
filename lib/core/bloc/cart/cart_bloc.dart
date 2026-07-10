import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/core/local/local_pref.dart';

import '../../../features/home/data/models/product_model.dart';
import '../../utils/enums.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<UpdateCartEvent>(_updateCart);
  }

  FutureOr<void> _updateCart(
      UpdateCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartRequestState: RequestState.loading));
    ProductModel productModel = await LocalPref.getProduct();
    int quantity = await LocalPref.getCart();
    emit(state.copyWith(
        cartRequestState: RequestState.loaded,
        quantity: quantity,
        product: productModel));
  }
}
