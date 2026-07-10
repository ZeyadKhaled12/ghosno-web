import 'package:flutter/material.dart';
import 'package:ghosno/features/home/presentation/screens/home_scr.dart';

import '../../../../configs/app_colors.dart';

class OrderCompleteWidgetSummary extends StatelessWidget {
  const OrderCompleteWidgetSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // --- Animated Success Icon (The "Gimmick") ---
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green.shade500,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Title ---
                  Text(
                    'Order Saved Successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- Subtitle ---
                  Text(
                    'Thank you for your purchase. Your order has been placed and is currently being processed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // // --- Order Details Card ---
                  // Container(
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade50,
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: Border.all(color: Colors.grey.shade200),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       _buildOrderDetailRow('Order Number:', '#ORD-89432'),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 40),

                  // --- Continue Shopping Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await Navigator.pushNamedAndRemoveUntil(
                            context, HomeScr.route, (route) => false);
                      },
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // // A small helper widget for the order details card
  // Widget _buildOrderDetailRow(String title, String value) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(
  //           color: Colors.grey.shade600,
  //           fontSize: 14,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       Text(
  //         value,
  //         style: const TextStyle(
  //           color: Colors.black87,
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
