import 'package:flutter/material.dart';
import '../../../cart/screens/cart_scr.dart';
import '../../../home/presentation/widgets/home_widget_appbar.dart';
import '../widgets/order_complete_widget_summary.dart';

class OrderCompleteScr extends StatefulWidget {
  const OrderCompleteScr({super.key});
  static const route = '/complete';

  @override
  State<OrderCompleteScr> createState() => _OrderCompleteScrState();
}

class _OrderCompleteScrState extends State<OrderCompleteScr> {
  final bool _isAppBarVisible = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          Positioned.fill(child: OrderCompleteWidgetSummary()),
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
