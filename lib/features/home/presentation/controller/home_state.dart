part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<ProductModel> products;
  final String productErrorMessage;
  final RequestState addToCartRequestState;
  final RequestState buyRequestState;
  final RequestState productsRequestState;
  final RequestState homeRequestState;

  const HomeState(
      {this.products = const [],
      this.productErrorMessage = '',
      this.addToCartRequestState = RequestState.loaded,
      this.buyRequestState = RequestState.loaded,
      this.productsRequestState = RequestState.loaded,
      this.homeRequestState = RequestState.loaded});

  HomeState copyWith(
      {List<ProductModel>? products,
      String? productErrorMessage,
      RequestState? addToCartRequestState,
      RequestState? buyRequestState,
      RequestState? productsRequestState,
      RequestState? homeRequestState}) {
    return HomeState(
        products: products ?? this.products,
        productErrorMessage: productErrorMessage ?? this.productErrorMessage,
        addToCartRequestState:
            addToCartRequestState ?? this.addToCartRequestState,
        buyRequestState: buyRequestState ?? this.buyRequestState,
        productsRequestState: productsRequestState ?? this.productsRequestState,
        homeRequestState: homeRequestState ?? this.homeRequestState);
  }

  @override
  List<Object> get props => [
        products,
        productErrorMessage,
        addToCartRequestState,
        buyRequestState,
        productsRequestState,
        homeRequestState
      ];
}
