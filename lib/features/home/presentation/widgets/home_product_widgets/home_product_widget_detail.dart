import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/core/bloc/cart/cart_bloc.dart';
import 'package:ghosno/core/utils/enums.dart';
import 'package:ghosno/features/checkout/presentation/screens/checkout_scr.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';
import 'package:ghosno/features/home/domain/usecases/add_to_cart_uc.dart';
import 'package:ghosno/features/home/domain/usecases/buy_uc.dart';
import 'package:ghosno/features/home/presentation/controller/home_bloc.dart';

import '../../../../../configs/app_colors.dart';
import '../../../../../configs/app_font.dart';
import '../../../../../core/utils/general_widgets/g_widget_loading.dart';

class HomeProductWidgetDetail extends StatefulWidget {
  const HomeProductWidgetDetail(
      {super.key,
      required this.productModel,
      required this.loading,
      required this.errormessage,
      required this.onOpenCart});
  final ProductModel productModel;
  final String errormessage;
  final Function() onOpenCart;
  final bool loading;

  @override
  State<HomeProductWidgetDetail> createState() =>
      _HomeProductWidgetDetailState();
}

class _HomeProductWidgetDetailState extends State<HomeProductWidgetDetail> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.productModel.name ?? 'Product',
          style: AppFont(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'LE ${widget.productModel.price}',
          style: AppFont(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 25),
        if ((widget.productModel.availableStock ?? 0) < 1)
          _buildSoldOutBadge()
        else ...[
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) => Text(
              state.quantity > 0
                  ? 'Quantity (${state.quantity} in cart)'
                  : 'Quantity',
              style: AppFont(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _QuantitySelector(
            loading: widget.loading,
            error: widget.errormessage,
            quantity: _quantity,
            onAdd: () {
              setState(() {
                _quantity = _quantity + 1;
              });
            },
            onMinus: () {
              setState(() {
                _quantity = _quantity - 1;
              });
            },
          ),
          const SizedBox(height: 32),
          _AddCartButton(
            productModel: widget.productModel,
            quantity: _quantity,
            onUpdateCart: () {
              widget.onOpenCart();
              setState(() {
                _quantity = 1;
              });
            },
          ),
          const SizedBox(height: 16),
          _BuyNowButton(
            productModel: widget.productModel,
            quantity: _quantity,
          )
        ],
      ],
    );
  }
}

class _BuyNowButton extends StatelessWidget {
  const _BuyNowButton({required this.productModel, required this.quantity});
  final ProductModel productModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
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
      builder: (context, state) => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: state.productsRequestState == RequestState.loading ||
                  state.buyRequestState == RequestState.loading
              ? null
              : () {
                  context.read<HomeBloc>().add(BuyEvent(
                      buyParameters: BuyParameters(
                          product: productModel, quantity: quantity)));
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: state.buyRequestState == RequestState.loading
              ? GWidgetLoadingCircle(
                  color: Colors.white, strokeWidth: 2, height: 28, width: 28)
              : Text(
                  'Buy it now',
                  style: AppFont(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

Widget _buildSoldOutBadge() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Colors.redAccent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.redAccent, width: 2),
    ),
    child: Center(
      child: Text(
        'Out of Stock',
        style: AppFont(
          color: Colors.redAccent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector(
      {required this.loading,
      required this.quantity,
      required this.onAdd,
      required this.onMinus,
      this.error});
  final bool loading;
  final String? error;
  final int quantity;
  final Function() onAdd;
  final Function() onMinus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 140,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: .5)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: loading || quantity < 2 ? null : onMinus,
                icon: Icon(Icons.remove,
                    color: quantity > 1 ? Colors.white : Colors.white24,
                    size: 20),
              ),
              Text(
                '$quantity',
                style: AppFont(color: Colors.white, fontSize: 18),
              ),
              IconButton(
                onPressed: loading ? null : onAdd,
                icon: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
        if (error != null)
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(error!,
                style:
                    AppFont(color: AppColors.red, fontWeight: FontWeight.w600)),
          )
      ],
    );
  }
}

class _AddCartButton extends StatelessWidget {
  const _AddCartButton(
      {required this.onUpdateCart,
      required this.quantity,
      required this.productModel});
  final Function() onUpdateCart;
  final int quantity;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.addToCartRequestState == RequestState.loaded) {
          context.read<CartBloc>().add(UpdateCartEvent());
          onUpdateCart();
        }
      },
      listenWhen: (previous, current) =>
          previous.addToCartRequestState != current.addToCartRequestState,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: state.productsRequestState == RequestState.loading ||
                    state.addToCartRequestState == RequestState.loading
                ? null
                : () {
                    context.read<HomeBloc>().add(AddToCartEvent(
                        addToCartParameters: AddToCartParameters(
                            product: productModel,
                            quantity: context.read<CartBloc>().state.quantity +
                                quantity)));
                  },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: state.addToCartRequestState == RequestState.loading
                ? GWidgetLoadingCircle(
                    color: Colors.white, strokeWidth: 2, height: 28, width: 28)
                : Text(
                    'Add to Cart',
                    style: AppFont(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
