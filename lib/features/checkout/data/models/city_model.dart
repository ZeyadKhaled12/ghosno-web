import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final int? id;
  final String? cityName;
  final String? shippingCost;

  const CityModel({this.id, this.cityName, this.shippingCost});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id'] as int?,
        cityName: json['city_name'] as String?,
        shippingCost: json['shipping_cost'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'city_name': cityName,
        'shipping_cost': shippingCost,
      };

  @override
  List<Object?> get props => [id, cityName, shippingCost];
}
