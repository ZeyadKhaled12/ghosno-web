part of 'cart_bloc.dart';

class CartState extends Equatable {
  final ProductModel product;
  final int quantity;
  final RequestState cartRequestState;

  const CartState(
      {this.product = const ProductModel(),
      this.quantity = 0,
      this.cartRequestState = RequestState.loaded});

  CartState copyWith(
      {ProductModel? product, int? quantity, RequestState? cartRequestState}) {
    return CartState(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      cartRequestState: cartRequestState ?? this.cartRequestState,
    );
  }

  @override
  List<Object> get props => [product, quantity, cartRequestState];
}
