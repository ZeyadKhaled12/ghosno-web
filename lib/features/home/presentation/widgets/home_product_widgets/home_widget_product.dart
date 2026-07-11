import 'package:flutter/material.dart';
import '../../../../../configs/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../data/models/product_model.dart';
import 'home_product_widget_detail.dart';

class HomeWidgetProduct extends StatelessWidget {
  const HomeWidgetProduct({
    super.key,
    required this.productModel,
    this.loading = false,
    required this.errormessage,
    required this.onOpenCart,
  });

  final ProductModel productModel;
  final String errormessage;
  final bool loading;
  final Function() onOpenCart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 800;

            if (isDesktop) {
              return _buildDesktopLayout(context);
            } else {
              return _buildMobileLayout(context);
            }
          },
        ),
        if (loading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _containerForm(Widget child, bool isDesktop) => Container(
      padding:
          EdgeInsets.symmetric(vertical: 40, horizontal: isDesktop ? 140 : 50),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.primary),
      child: child);

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 2000),
          child: _containerForm(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: HomeProductWidgetDetail(
                          errormessage: errormessage,
                          productModel: productModel,
                          onOpenCart: onOpenCart,
                          loading: loading)),
                  const SizedBox(width: 120),
                  Expanded(
                    flex: 1,
                    child: _buildProductImage(isDesktop: true),
                  ),
                ],
              ),
              true)),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _containerForm(
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(isDesktop: false),
                const SizedBox(height: 32),
                HomeProductWidgetDetail(
                    errormessage: errormessage,
                    productModel: productModel,
                    onOpenCart: onOpenCart,
                    loading: loading),
              ],
            ),
          ),
        ),
        false);
  }

  Widget _buildProductImage({required bool isDesktop}) {
    return Container(
      width: double.infinity,
      height: isDesktop ? 500 : 400,
      decoration: BoxDecoration(
        color: const Color(0XFFEAE5EB),
        image: DecorationImage(
          image: productModel.imageUrl == null
              ? AssetImage(ImgAsset.product) as ImageProvider
              : NetworkImage(productModel.imageUrl!),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
