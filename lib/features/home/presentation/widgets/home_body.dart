import 'package:flutter/material.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../cart/screens/cart_scr.dart';
import 'home_widget_appbar.dart';
import 'home_widget_bottom.dart';
import 'home_widget_header_img.dart';
import 'home_widget_images.dart';
import 'home_product_widgets/home_widget_product.dart';

class HomeBody extends StatefulWidget {
  const HomeBody(
      {super.key,
      required this.products,
      required this.productsLoading,
      required this.productErrorMessage});
  final List<ProductModel> products;
  final bool productsLoading;
  final String productErrorMessage;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late ScrollController _scrollController;
  bool _isAppBarVisible = true;
  double _lastScrollOffset = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _productKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double currentOffset = _scrollController.offset;
    if (currentOffset <= 0) {
      if (!_isAppBarVisible) {
        setState(() => _isAppBarVisible = true);
      }
      _lastScrollOffset = currentOffset;
      return;
    }

    if (currentOffset > _lastScrollOffset && _isAppBarVisible) {
      setState(() => _isAppBarVisible = false);
    } else if (currentOffset < _lastScrollOffset && !_isAppBarVisible) {
      setState(() => _isAppBarVisible = true);
    }

    _lastScrollOffset = currentOffset;
  }

  void _scrollToProduct() {
    final BuildContext? productContext = _productKey.currentContext;

    if (productContext != null) {
      Scrollable.ensureVisible(productContext,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isDesktop = screenWidth > 800;

    final PreferredSizeWidget customAppBar = HomeWidgetAppbar(
      isDesktop: isDesktop,
      onCart: () {
        _scaffoldKey.currentState?.openEndDrawer();
      },
    ).appbar(context);

    final double appBarHeight = customAppBar.preferredSize.height;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const CartScr(),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(height: appBarHeight),
                  HomeWidgetHeaderImg(
                    isDesktop: isDesktop,
                    onShopNow: () {
                      _scrollToProduct();
                    },
                  ),
                  SizedBox(
                    key: _productKey,
                    child: HomeWidgetProduct(
                      onOpenCart: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      loading: widget.productsLoading,
                      errormessage: widget.productErrorMessage,
                      productModel:
                          widget.products.firstOrNull ?? ProductModel(),
                    ),
                  ),
                  SizedBox(height: 40),
                  HomeWidgetImages(),
                  const SizedBox(height: 40),
                  HomeWidgetBottom(),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            top: _isAppBarVisible ? 0 : -appBarHeight,
            left: 0,
            right: 0,
            child: Container(
              height: appBarHeight,
              color: Colors.white,
              child: customAppBar,
            ),
          ),
        ],
      ),
    );
  }
}
