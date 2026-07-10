import 'package:flutter/material.dart';

import '../../../../configs/app_colors.dart';
import '../../../cart/screens/cart_scr.dart';
import '../widgets/home_widget_appbar.dart';
import '../widgets/home_widget_bottom.dart';

class TermsConditionsScr extends StatefulWidget {
  const TermsConditionsScr({super.key});
  static const route = '/terms-of-service';

  @override
  State<TermsConditionsScr> createState() => _TermsConditionsScrState();
}

class _TermsConditionsScrState extends State<TermsConditionsScr> {
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
        }).appbar(context);
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
                            'Terms of service',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 32),
                          _TermsBody(),
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

class _TermsBody extends StatelessWidget {
  const _TermsBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildParagraph(
          'Welcome to Ghosno. This website is operated by Ghosno. Throughout the site, the terms “we”, “us” and “our” refer to Ghosno. We offer this website, including all information, tools, and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies, and notices stated here.\n\n'
          'By visiting our site and/or purchasing our Yerba Mate Cocido products, you engage in our “Service” and agree to be bound by the following terms and conditions (“Terms of Service”, “Terms”). Please read these Terms of Service carefully before accessing or using our website.',
        ),
        _buildSectionHeading('1. Online Store Terms'),
        _buildParagraph(
          'By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence.\n\n'
          'You may not use our Yerba Mate Cocido products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws). A breach or violation of any of the Terms will result in an immediate termination of your Services.',
        ),
        _buildSectionHeading('2. General Conditions'),
        _buildParagraph(
          'We reserve the right to refuse service to anyone for any reason at any time. You understand that your content (not including credit card information), may be transferred unencrypted and involve transmissions over various networks.\n\n'
          'Credit card information is always encrypted during transfer over networks. You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service without express written permission by us.',
        ),
        _buildSectionHeading('3. Accuracy and Completeness of Information'),
        _buildParagraph(
          'We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, or more complete sources of information.\n\n'
          'We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.',
        ),
        _buildSectionHeading('4. Modifications to the Service and Prices'),
        _buildParagraph(
          'Prices for our Yerba Mate Cocido tea bags and packages are subject to change without notice. We reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice at any time.\n\n'
          'We shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.',
        ),
        _buildSectionHeading('5. Products or Services'),
        _buildParagraph(
          'Certain premium Yerba Mate Cocido variants may be available exclusively online through the website. These products may have limited quantities and are subject to return or exchange only according to our Refund Policy.\n\n'
          'We have made every effort to display as accurately as possible the colors and images of our product packaging that appears at the store. We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction.',
        ),
        _buildSectionHeading('6. Accuracy of Billing and Account Information'),
        _buildParagraph(
          'We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made.\n\n'
          'You agree to provide current, complete and accurate purchase and account information for all purchases made at our store.',
        ),
        _buildSectionHeading('7. Optional Tools and Third-Party Links'),
        _buildParagraph(
          'We may provide you with access to third-party tools or payment gateways over which we neither monitor nor have any control nor input. Third-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability for any third-party materials or websites.',
        ),
        _buildSectionHeading('8. Prohibited Uses'),
        _buildParagraph(
          'In addition to other prohibitions as set forth in the Terms of Service, you are prohibited from using the site or its content: (a) for any unlawful purpose; (b) to solicit others to perform or participate in any unlawful acts; (c) to violate any international, federal, provincial or state regulations, rules, or laws; (d) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (e) to submit false or misleading information; or (f) to upload or transmit viruses or any other type of malicious code.',
        ),
        _buildSectionHeading(
            '9. Disclaimer of Warranties; Limitation of Liability'),
        _buildParagraph(
          'We do not guarantee, represent or warrant that your use of our service will be uninterrupted, timely, secure or error-free. We do not warrant that the results that may be obtained from the use of the service will be accurate or reliable.\n\n'
          'In no case shall Ghosno, our directors, officers, employees, affiliates, agents, contractors, or interns be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, arising from your use of any of the service or any products procured using the service.',
        ),
        _buildSectionHeading('10. Governing Law'),
        _buildParagraph(
          'These Terms of Service and any separate agreements whereby we provide you Services shall be governed by and construed in accordance with the laws of the jurisdiction in which Ghosno operates.',
        ),
        _buildSectionHeading('11. Contact Information'),
        _buildParagraph(
          'Questions about the Terms of Service should be sent to us directly via email at **support@ghosno.com**.',
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
        fontSize: 15,
        height: 1.7,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
