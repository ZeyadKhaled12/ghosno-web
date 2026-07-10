import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? id;
  final String? name;
  final String? price;
  final int? availableStock;
  final String? imageUrl;

  const ProductModel({
    this.id,
    this.name,
    this.price,
    this.availableStock,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        price: json['price'] as String?,
        availableStock: json['available_stock'] as int?,
        imageUrl: json['image_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'available_stock': availableStock,
        'image_url': imageUrl,
      };

  @override
  List<Object?> get props => [id, name, price, availableStock, imageUrl];
}
