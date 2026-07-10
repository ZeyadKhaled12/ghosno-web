import 'package:flutter/material.dart';

import '../../../../configs/app_colors.dart';
import '../../../cart/screens/cart_scr.dart';
import '../widgets/home_widget_appbar.dart';
import '../widgets/home_widget_bottom.dart';

class PrivacyPolicyScr extends StatefulWidget {
  const PrivacyPolicyScr({super.key});
  static const route = '/privacy-policy';

  @override
  State<PrivacyPolicyScr> createState() => _PrivacyPolicyScrState();
}

class _PrivacyPolicyScrState extends State<PrivacyPolicyScr> {
  late ScrollController _scrollController;
  bool _isAppBarVisible = true;
  double _lastScrollOffset = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      // Scrolling Down -> Hide App Bar smoothly
      setState(() => _isAppBarVisible = false);
    } else if (currentOffset < _lastScrollOffset && !_isAppBarVisible) {
      // Scrolling Up -> Show App Bar smoothly
      setState(() => _isAppBarVisible = true);
    }

    _lastScrollOffset = currentOffset;
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 40.0 : 24.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 90),
                          Text(
                            'Privacy Policy',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 32),
                          _PolicyBody(),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    HomeWidgetBottom(),
                  ],
                ),
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

class _PolicyBody extends StatelessWidget {
  const _PolicyBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'This Privacy Policy describes how Ghosno ("we", "us", or "our") collects, uses, and discloses your Personal Information when you visit or make a purchase from our website (the "Site") to buy our premium Yerba Mate Cocido products.',
        ),
        _buildSectionHeading('1. Personal Information We Collect'),
        _buildParagraph(
          'When you visit the Site, we collect certain information about your device, your interaction with the Site, and information necessary to process your purchases of Yerba Mate Cocido.\n\n'
          '• **Device Information:** Examples of Personal Information collected include browser version, IP address, time zone, cookie information, what sites or products you view, search terms, and how you interact with the Site.\n'
          '• **Order Information:** Examples of Personal Information collected include name, billing address, shipping address, payment information, email address, and phone number.',
        ),
        _buildSectionHeading('2. How We Use Your Personal Information'),
        _buildParagraph(
          'We use your personal information to provide our services and products to you. This includes: offering Yerba Mate Cocido products for sale, processing secure payments, arranging for fulfillment and shipping of your orders, keeping you updated on new arrivals or promotions, and communicating directly with you regarding any customer support queries.',
        ),
        _buildSectionHeading('3. Sharing Personal Information'),
        _buildParagraph(
          'We share your Personal Information with reliable third-party service providers to help us use your Personal Information, as described above. For example, we share your information with payment gateways to process your credit card transactions securely and with local logistics and delivery partners to ship our Mate Cocido boxes directly to your doorstep.',
        ),
        _buildSectionHeading('4. Cookies and Web Tracking'),
        _buildParagraph(
          'A cookie is a small amount of information that’s downloaded to your computer or device when you visit our Site. We use a number of different cookies, including functional, performance, and marketing cookies to optimize your browsing experience and remember your preference choices.',
        ),
        _buildSectionHeading('5. Data Retention'),
        _buildParagraph(
          'When you place an order for Yerba Mate Cocido through the Site, we will retain your Personal Information for our internal records unless and until you ask us to erase this information. For more information on your right of erasure, please see the ‘Your Rights’ section below.',
        ),
        _buildSectionHeading('6. Your Rights'),
        _buildParagraph(
          'You have the right to access the personal information we hold about you, to port it to a new service, and to ask that your Personal Information be corrected, updated, or erased. If you would like to exercise these rights, please contact us through the contact details listed below.',
        ),
        _buildSectionHeading('7. Changes to This Policy'),
        _buildParagraph(
          'We may update this Privacy Policy from time to time in order to reflect, for example, changes to our operational practices or for other legal, regulatory, or business reasons.',
        ),
        _buildSectionHeading('8. Contact Us'),
        _buildParagraph(
          'For more information about our privacy practices, if you have questions, or if you would like to make a complaint, please contact us by e-mail at **support@ghosno.com**.',
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 3,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return SelectableText(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        height: 1.7,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
