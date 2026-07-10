import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/configs/app_font.dart';
import 'package:ghosno/core/bloc/cart/cart_bloc.dart';
import 'package:ghosno/core/utils/assets_manager.dart';
import 'package:ghosno/features/home/presentation/screens/home_scr.dart';

class HomeWidgetAppbar {
  HomeWidgetAppbar({required this.isDesktop, required this.onCart});
  final bool isDesktop;
  final Function() onCart;

  PreferredSizeWidget appbar(BuildContext context) {
    final double customToolbarHeight = isDesktop ? 90.0 : 70.0;
    return AppBar(
      centerTitle: true,
      toolbarHeight: customToolbarHeight,
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: .5),
      leadingWidth: isDesktop ? 240 : 190,
      leading: _contactUsBtn(() {}),
      title: InkWell(
          onTap: () {
            String? currentRoute = ModalRoute.of(context)?.settings.name;
            if (currentRoute == HomeScr.route) return;
            Navigator.pushNamed(context, HomeScr.route);
          },
          child: Image.asset(ImgAsset.logo, color: Colors.white, width: 100)),
      actions: [
        _ShoppingBagIcon(onPressed: onCart),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _contactUsBtn(VoidCallback onPressed) => Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 8,
            shadowColor: AppColors.primary.withValues(alpha: .5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: AppColors.secondary, width: 1.5)),
          ),
          child: Text(
            'Contact us',
            style: AppFont(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 1.5),
          ),
        ),
      );
}

class _ShoppingBagIcon extends StatefulWidget {
  const _ShoppingBagIcon({required this.onPressed});
  final Function() onPressed;

  @override
  State<_ShoppingBagIcon> createState() => _ShoppingBagIconState();
}

class _ShoppingBagIconState extends State<_ShoppingBagIcon> {
  @override
  void initState() {
    context.read<CartBloc>().add(UpdateCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, size: 29),
                onPressed: widget.onPressed),
            if (state.quantity > 0)
              Positioned(
                right: 6,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${state.quantity}',
                    style: AppFont(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
