import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/configs/app_font.dart';
import 'package:ghosno/core/utils/enums.dart';
import 'package:ghosno/core/utils/general_widgets/g_widget_loading.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';
import 'package:ghosno/features/home/domain/usecases/buy_uc.dart';
import 'package:ghosno/features/home/presentation/controller/home_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../checkout/presentation/screens/checkout_scr.dart';

class CartWidgetFooter extends StatelessWidget {
  const CartWidgetFooter(
      {super.key,
      required this.total,
      required this.productModel,
      required this.quantity});
  final num total;
  final ProductModel productModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.buyRequestState == RequestState.loaded) {
            Navigator.pushNamed(context, CheckoutScr.route,
                arguments:
                    CheckoutArgu(productModel: productModel, quantity: quantity)
                        .toArgu());
          }
        },
        listenWhen: (previous, current) =>
            previous.buyRequestState != current.buyRequestState,
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(height: 1, thickness: 1),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated total',
                        style: AppFont(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'LE ${total.toStringAsFixed(2)}',
                        style: AppFont(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Taxes, discounts and shipping calculated at checkout.',
                    style:
                        AppFont(color: Colors.grey, fontSize: 13, height: 1.3),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<HomeBloc>().add(BuyEvent(
                          buyParameters: BuyParameters(
                              product: productModel, quantity: quantity)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: state.buyRequestState == RequestState.loading
                        ? GWidgetLoadingCircle(
                            color: Colors.white,
                            width: 24,
                            height: 24,
                            strokeWidth: 2.9,
                          )
                        : Text(
                            'Check out',
                            style: AppFont(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                  ),
                  if (state.productErrorMessage.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        state.productErrorMessage,
                        style: AppFont(
                            color: Colors.red,
                            fontSize: 13,
                            height: 1.3,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
