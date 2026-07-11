import 'package:flutter/material.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../../configs/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../data/models/city_model.dart';
import 'checkout_widget_from.dart';
import 'checkout_widget_mobile_summary.dart';
import 'checkout_widget_order_summary.dart';

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({super.key, required this.parameters});
  final CheckoutBodyParameters parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 850) {
            return _buildWebLayout(context, parameters: parameters);
          } else {
            return _buildMobileLayout(parameters: parameters);
          }
        },
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context,
      {required CheckoutBodyParameters parameters}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                left: 150, right: 80.0, top: 40.0, bottom: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(ImgAsset.logo,
                    width: 129, color: AppColors.primary),
                const SizedBox(height: 30),
                CheckoutWidgetFrom(
                    isMobile: false,
                    cities: parameters.cities,
                    productModel: parameters.productModel,
                    calculateResultModel: parameters.calculateResultModel,
                    quantity: parameters.quantity,
                    createOrderLoading: parameters.createOrderLoading,
                    citiesLoading: parameters.citiesLoading),
              ],
            ),
          ),
        ),
        Container(width: 1, color: Colors.grey.shade200),
        Expanded(
          flex: 4,
          child: Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.only(
                  left: 60.0, right: 120.0, top: 60.0, bottom: 60.0),
              child: CheckoutWidgetOrderSummary(
                quantity: parameters.quantity,
                calculateLoading:
                    parameters.calculateLoading || parameters.citiesLoading,
                calculateResultModel: parameters.calculateResultModel,
                productModel: parameters.productModel,
              )),
        ),
      ],
    );
  }

  Widget _buildMobileLayout({required CheckoutBodyParameters parameters}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Image.asset(ImgAsset.logo,
                    width: 129, color: AppColors.primary)),
          ),
          const Divider(height: 1),
          CheckoutWidgetMobileSummary(
            quantity: parameters.quantity,
            calculateResultModel: parameters.calculateResultModel,
            loading: parameters.calculateLoading || parameters.citiesLoading,
            productModel: parameters.productModel,
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: CheckoutWidgetFrom(
                isMobile: true,
                cities: parameters.cities,
                productModel: parameters.productModel,
                calculateResultModel: parameters.calculateResultModel,
                quantity: parameters.quantity,
                createOrderLoading: parameters.createOrderLoading,
                citiesLoading: parameters.citiesLoading),
          ),
        ],
      ),
    );
  }
}

class CheckoutBodyParameters {
  final bool createOrderLoading;
  final bool citiesLoading;
  final List<CityModel> cities;
  final bool calculateLoading;
  final CalculateResultModel calculateResultModel;
  final ProductModel productModel;
  final int quantity;

  CheckoutBodyParameters(
      {required this.createOrderLoading,
      required this.citiesLoading,
      required this.cities,
      required this.calculateLoading,
      required this.calculateResultModel,
      required this.productModel,
      required this.quantity});
}
