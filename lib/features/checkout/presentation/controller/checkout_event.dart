part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class GetCitiesEvent extends CheckoutEvent {
  final NoParameters noParameters;
  const GetCitiesEvent({required this.noParameters});
  @override
  List<Object> get props => [noParameters];
}

class CalculateEvent extends CheckoutEvent {
  final CalculateParameters calculateParameters;
  const CalculateEvent({required this.calculateParameters});
  @override
  List<Object> get props => [calculateParameters];
}

class CreateOrderEvent extends CheckoutEvent {
  final CreateOrderParameters createOrderParameters;
  const CreateOrderEvent({required this.createOrderParameters});
  @override
  List<Object> get props => [createOrderParameters];
}
