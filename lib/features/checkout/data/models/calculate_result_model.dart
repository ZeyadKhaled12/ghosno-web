import 'package:equatable/equatable.dart';

class CalculateResultModel extends Equatable {
  final bool? isValid;
  final num? subtotal;
  final num? shippingCost;
  final num? discountAmount;
  final num? grandTotal;
  final String? errorMessage;

  const CalculateResultModel({
    this.isValid,
    this.subtotal,
    this.shippingCost,
    this.discountAmount,
    this.grandTotal,
    this.errorMessage,
  });

  factory CalculateResultModel.fromJson(Map<String, dynamic> json) {
    return CalculateResultModel(
        isValid: json['is_valid'] as bool?,
        subtotal: json['subtotal'] as num?,
        shippingCost: json['shipping_cost'] as num?,
        discountAmount: json['discount_amount'] as num?,
        grandTotal: json['grand_total'] as num?,
        errorMessage: json['error_message'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'is_valid': isValid,
        'subtotal': subtotal,
        'shipping_cost': shippingCost,
        'discount_amount': discountAmount,
        'grand_total': grandTotal,
        'error_message': errorMessage,
      };

  @override
  List<Object?> get props {
    return [
      isValid,
      subtotal,
      shippingCost,
      discountAmount,
      grandTotal,
      errorMessage,
    ];
  }
}
