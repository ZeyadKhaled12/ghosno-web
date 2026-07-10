import 'package:flutter/material.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/configs/app_font.dart';

import '../../../../core/utils/assets_manager.dart';

class HomeWidgetHeaderImg extends StatelessWidget {
  const HomeWidgetHeaderImg(
      {super.key, required this.isDesktop, required this.onShopNow});
  final bool isDesktop;
  final Function() onShopNow;

  @override
  Widget build(BuildContext context) {
    final double imageHeight = isDesktop ? 600.0 : 250.0;

    return Container(
      width: double.infinity,
      height: imageHeight,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImgAsset.header,
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: .3),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.secondary),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: .5),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                  onPressed: onShopNow,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0),
                  child: Text(
                    'Shop Now',
                    style: AppFont(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
