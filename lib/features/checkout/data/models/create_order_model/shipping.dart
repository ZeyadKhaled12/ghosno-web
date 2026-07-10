import 'package:equatable/equatable.dart';

class Shipping extends Equatable {
  final int cityId;
  final String address;
  final String? postalCode;
  final String? apartmentSuite;

  const Shipping({
    required this.cityId,
    required this.address,
    this.postalCode,
    this.apartmentSuite,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      cityId: json['city_id'] as int,
      address: json['address'] as String,
      postalCode: json['postal_code'] as String?,
      apartmentSuite: json['apartment_suite'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {
      'city_id': cityId,
      'address': address,
      'postal_code': postalCode,
      'apartment_suite': apartmentSuite,
    };
    body.removeWhere((key, value) => value == null);
    return body;
  }

  @override
  List<Object?> get props {
    return [
      cityId,
      address,
      postalCode,
      apartmentSuite,
    ];
  }
}
