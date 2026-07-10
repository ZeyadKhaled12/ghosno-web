import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/core/utils/enums.dart';
import 'package:ghosno/features/checkout/presentation/controller/checkout_bloc.dart';
import 'package:ghosno/features/checkout/presentation/widgets/checkout_body.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../../core/services/services_locator.dart';

class CheckoutScr extends StatelessWidget {
  const CheckoutScr({super.key});
  static const route = '/Checkout';

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    CheckoutArgu argu = CheckoutArgu(productModel: ProductModel(), quantity: 1);
    if (data != null) {
      argu = CheckoutArgu.fromJson(data);
    }

    return BlocProvider(
        create: (context) => sl<CheckoutBloc>()
          ..add(GetCitiesEvent(noParameters: NoParameters())),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            return CheckoutBody(
              parameters: CheckoutBodyParameters(
                  productModel: argu.productModel,
                  quantity: argu.quantity,
                  citiesLoading:
                      state.getCitiesRequestState == RequestState.loading,
                  calculateLoading:
                      state.calculateRequestState == RequestState.loading,
                  createOrderLoading:
                      state.createOrderRequestState == RequestState.loading,
                  calculateResultModel: state.calculateResultModel,
                  cities: state.cities),
            );
          },
        ));
  }
}

class CheckoutArgu {
  final ProductModel productModel;
  final int quantity;
  CheckoutArgu({required this.productModel, required this.quantity});
  Map<String, dynamic> toArgu() =>
      {'productModel': productModel, 'quantity': quantity};
  factory CheckoutArgu.fromJson(Map<String, dynamic> argu) => CheckoutArgu(
      productModel: argu['productModel'], quantity: argu['quantity']);
}
