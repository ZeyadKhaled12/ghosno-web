part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends HomeEvent {
  final NoParameters noParameters;
  const GetProductsEvent({required this.noParameters});
  @override
  List<Object> get props => [noParameters];
}

class AddToCartEvent extends HomeEvent {
  final AddToCartParameters addToCartParameters;
  const AddToCartEvent({required this.addToCartParameters});
  @override
  List<Object> get props => [addToCartParameters];
}

class BuyEvent extends HomeEvent {
  final BuyParameters buyParameters;
  const BuyEvent({required this.buyParameters});
  @override
  List<Object> get props => [buyParameters];
}

class SendCommentEvent extends HomeEvent {
  final SendCommentParameters sendCommentParameters;
  const SendCommentEvent({required this.sendCommentParameters});
  @override
  List<Object> get props => [sendCommentParameters];
}
