import 'package:equatable/equatable.dart';

import 'customer.dart';
import 'order_details.dart';
import 'shipping.dart';

class CreateOrderModel extends Equatable {
  final Customer customer;
  final Shipping shipping;
  final OrderDetails orderDetails;

  const CreateOrderModel(
      {required this.customer,
      required this.shipping,
      required this.orderDetails});

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderModel(
        customer: Customer.fromJson(json['customer']),
        shipping: Shipping.fromJson(json['shipping']),
        orderDetails: OrderDetails.fromJson(json['order_details']));
  }

  Map<String, dynamic> toJson() => {
        'customer': customer.toJson(),
        'shipping': shipping.toJson(),
        'order_details': orderDetails.toJson(),
      };

  @override
  List<Object?> get props => [customer, shipping, orderDetails];
}
