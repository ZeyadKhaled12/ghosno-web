import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/features/checkout/domain/usecases/calculate_uc.dart';
import 'package:ghosno/features/checkout/presentation/controller/checkout_bloc.dart';

import '../../../../configs/app_font.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/general_widgets/g_widget_loading.dart';
import '../../../home/data/models/product_model.dart';
import '../../data/models/calculate_result_model.dart';

class CheckoutWidgetOrderSummary extends StatefulWidget {
  const CheckoutWidgetOrderSummary({
    super.key,
    required this.calculateLoading,
    required this.productModel,
    required this.calculateResultModel,
    required this.quantity,
  });
  final bool calculateLoading;
  final ProductModel productModel;
  final int quantity;
  final CalculateResultModel calculateResultModel;

  @override
  State<CheckoutWidgetOrderSummary> createState() =>
      _CheckoutWidgetOrderSummaryState();
}

class _CheckoutWidgetOrderSummaryState
    extends State<CheckoutWidgetOrderSummary> {
  final TextEditingController _promoCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GWidgetLoading(
      isLoading: widget.calculateLoading,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        image: DecorationImage(
                            image: widget.productModel.imageUrl == null
                                ? AssetImage(ImgAsset.product)
                                : NetworkImage(widget.productModel.imageUrl!),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text('${widget.quantity}',
                            style: AppFont(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                  child: Text(widget.productModel.name ?? 'Product',
                      style: AppFont(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black87))),
              Text('LE ${widget.productModel.price ?? 0}',
                  style: AppFont(fontWeight: FontWeight.w400, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: TextField(
                    controller: _promoCode,
                    style: AppFont(fontWeight: FontWeight.bold),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: 'Discount code',
                        border: InputBorder.none,
                        hintStyle: AppFont(
                            color: Colors.grey, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    foregroundColor: Colors.grey.shade700,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  onPressed: () {
                    if (_promoCode.text.isNotEmpty &&
                        context.read<CheckoutBloc>().state.citySelectedID !=
                            null) {
                      context.read<CheckoutBloc>().add(CalculateEvent(
                          calculateParameters: CalculateParameters(
                              productID: widget.productModel.id!,
                              cityID: context
                                  .read<CheckoutBloc>()
                                  .state
                                  .citySelectedID!,
                              quantity: widget.quantity,
                              promoCode: _promoCode.text)));
                    }
                  },
                  child: Text('Apply',
                      style:
                          AppFont(fontSize: 14, fontWeight: FontWeight.w400)),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal',
                  style: AppFont(color: Colors.grey.shade600, fontSize: 14)),
              Text('LE ${widget.calculateResultModel.subtotal ?? 0}',
                  style: AppFont(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping',
                  style: AppFont(color: Colors.grey.shade600, fontSize: 14)),
              Text('LE ${widget.calculateResultModel.shippingCost ?? 0}',
                  style: AppFont(fontSize: 14)),
            ],
          ),

          // --- NEW DISCOUNT ROW ADDED HERE ---
          if (widget.calculateResultModel.discountAmount != null &&
              widget.calculateResultModel.discountAmount! > 0) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount',
                    style: AppFont(color: Colors.green.shade600, fontSize: 14)),
                Text('- LE ${widget.calculateResultModel.discountAmount ?? 0}',
                    style: AppFont(
                        color: Colors.green.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
          // -----------------------------------

          const Divider(height: 36, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: AppFont(fontSize: 16, color: Colors.black87)),
              Text('LE ${widget.calculateResultModel.grandTotal ?? 0}',
                  style: AppFont(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }
}
