import 'package:equatable/equatable.dart';

class CheckStockModel extends Equatable {
  final bool? isAvailable;
  final int? requestedQuantity;
  final int? availableStock;
  final String? message;

  const CheckStockModel({
    this.isAvailable,
    this.requestedQuantity,
    this.availableStock,
    this.message,
  });

  factory CheckStockModel.fromJson(Map<String, dynamic> json) {
    return CheckStockModel(
      isAvailable: json['is_available'] as bool?,
      requestedQuantity: json['requested_quantity'] as int?,
      availableStock: json['available_stock'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'is_available': isAvailable,
        'requested_quantity': requestedQuantity,
        'available_stock': availableStock,
        'message': message,
      };

  @override
  List<Object?> get props {
    return [
      isAvailable,
      requestedQuantity,
      availableStock,
      message,
    ];
  }
}
