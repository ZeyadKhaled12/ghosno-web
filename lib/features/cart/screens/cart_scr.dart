import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/configs/app_font.dart';
import 'package:ghosno/core/bloc/cart/cart_bloc.dart';
import 'package:ghosno/features/home/presentation/screens/home_scr.dart';

import '../widgets/cart_widget_footer.dart';
import '../widgets/cart_widget_header.dart';
import '../widgets/cart_widget_item_list.dart';

class CartScr extends StatelessWidget {
  const CartScr({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double drawerWidth = screenWidth > 600 ? 450.0 : screenWidth * 0.85;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) => Drawer(
        width: drawerWidth,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.white,
        child: SafeArea(
          child: state.quantity < 1
              ? EmptyCartWidget()
              : Column(children: [
                  CartWidgetHeader(),
                  CartWidgetItemList(
                    productModel: state.product,
                    quantity: state.quantity,
                  ),
                  CartWidgetFooter(
                    productModel: state.product,
                    quantity: state.quantity,
                    total:
                        state.quantity * num.parse(state.product.price ?? '0'),
                  )
                ]),
        ),
      ),
    );
  }
}

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your cart is empty',
              style: AppFont(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  fontSize: 22),
            ),
            const SizedBox(height: 12),
            Text(
              'Looks like you haven\'t added anything yet.\nLet\'s change that!',
              textAlign: TextAlign.center,
              style: AppFont(
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamedAndRemoveUntil(
                      context, HomeScr.route, (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Continue Shopping',
                  style: AppFont(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
