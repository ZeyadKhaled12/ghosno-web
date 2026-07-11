import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/configs/app_font.dart';
import 'package:ghosno/core/bloc/cart/cart_bloc.dart';
import 'package:ghosno/core/local/local_pref.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../core/utils/assets_manager.dart';

class CartWidgetItemList extends StatelessWidget {
  const CartWidgetItemList(
      {super.key, required this.productModel, required this.quantity});
  final ProductModel productModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: productModel.imageUrl == null
                    ? AssetImage(ImgAsset.product)
                    : NetworkImage(productModel.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CartItemDetailsRow(
                    productModel: productModel, quantity: quantity),
                SizedBox(height: 16),
                _CartItemActionsRow(
                    quantity: quantity, productModel: productModel),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class _CartItemDetailsRow extends StatelessWidget {
  const _CartItemDetailsRow(
      {required this.productModel, required this.quantity});
  final ProductModel productModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.name ?? 'Product',
                style: AppFont(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'LE ${productModel.price}',
                style: AppFont(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(width: 15),
        Text(
          'LE\n${(num.parse(productModel.price ?? '0') * quantity).toStringAsFixed(2)}',
          textAlign: TextAlign.end,
          style: AppFont(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CartItemActionsRow extends StatelessWidget {
  const _CartItemActionsRow(
      {required this.quantity, required this.productModel});
  final int quantity;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 16),
                onPressed: quantity <= 1
                    ? null
                    : () async {
                        await LocalPref.setCart(quantity - 1, productModel);
                        context.read<CartBloc>().add(UpdateCartEvent());
                      },
                constraints: const BoxConstraints(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              SizedBox(width: 15),
              Text(
                '$quantity',
                style: AppFont(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 15),
              IconButton(
                icon: const Icon(Icons.add, size: 16),
                onPressed: () async {
                  await LocalPref.setCart(quantity + 1, productModel);
                  context.read<CartBloc>().add(UpdateCartEvent());
                },
                constraints: const BoxConstraints(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
            icon: Image.asset(IconAsset.trash, width: 22),
            onPressed: () async {
              await LocalPref.setCart(0, productModel);
              context.read<CartBloc>().add(UpdateCartEvent());
            }),
      ],
    );
  }
}
