import 'package:equatable/equatable.dart';

class OrderDetails extends Equatable {
  final int productId;
  final int? quantity;
  final String? promoCode;

  const OrderDetails({required this.productId, this.quantity, this.promoCode});

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      productId: json['product_id'] as int,
      quantity: json['quantity'] as int?,
      promoCode: json['promo_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {
      'product_id': productId,
      'quantity': quantity,
      'promo_code': promoCode,
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }

  @override
  List<Object?> get props => [productId, quantity, promoCode];
}
