import 'package:flutter/material.dart';
import 'package:ghosno/configs/app_font.dart';

class CartWidgetHeader extends StatelessWidget {
  const CartWidgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Cart',
                style: AppFont(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 28, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product',
                style: AppFont(
                    color: Colors.black54, fontSize: 15, letterSpacing: 1.1),
              ),
              Text(
                'Total',
                style: AppFont(
                    color: Colors.black54, fontSize: 15, letterSpacing: 1.1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
