import 'package:flutter/material.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../../configs/app_colors.dart';
import '../../../../configs/app_font.dart';
import 'checkout_widget_order_summary.dart';

class CheckoutWidgetMobileSummary extends StatelessWidget {
  const CheckoutWidgetMobileSummary(
      {super.key,
      required this.calculateResultModel,
      required this.loading,
      required this.productModel,
      required this.quantity});
  final bool loading;
  final ProductModel productModel;
  final int quantity;
  final CalculateResultModel calculateResultModel;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: Colors.grey.shade50,
        collapsedBackgroundColor: Colors.grey.shade50,
        trailing:
            const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
        title: Row(
          children: [
            Icon(Icons.shopping_cart_outlined,
                size: 20, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              "Show order summary",
              style: AppFont(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        subtitle: Text("LE ${calculateResultModel.grandTotal} Total",
            style: AppFont(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87)),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: CheckoutWidgetOrderSummary(
                calculateLoading: loading,
                productModel: productModel,
                quantity: quantity,
                calculateResultModel: calculateResultModel),
          ),
        ],
      ),
    );
  }
}
