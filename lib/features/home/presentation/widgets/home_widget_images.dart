import 'package:flutter/material.dart';
import 'package:ghosno/core/utils/assets_manager.dart';

import '../../../../configs/app_colors.dart';
import '../../../../configs/app_font.dart';

class HomeWidgetImages extends StatelessWidget {
  const HomeWidgetImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ResponsiveStepWidget(
          assetPath: ImgAsset.presentation1,
          title: 'The Healthy Alternative to Coffee',
          body:
              'Get a long-lasting boost of natural energy without feeling jittery. "Ghosno" Mate is the perfect choice for staying focused throughout the day.',
        ),
        _ResponsiveStepWidget(
          assetPath: ImgAsset.presentation2,
          isRight: false,
          title: 'Mental Clarity and Peace of Mind',
          body:
              'Ghosno’s Mate Cocido supports brain function, giving you the focus you need to complete complex tasks while reducing feelings of stress.',
        ),
        _ResponsiveStepWidget(
            assetPath: ImgAsset.presentation3,
            title: 'Your Partner in a Healthy Lifestyle',
            body:
                'Enjoy an antioxidant-rich drink that supports metabolism. "Ghosno" Mate is the ideal choice to complete your active day.'),
      ],
    );
  }
}

class _ResponsiveStepWidget extends StatelessWidget {
  final String assetPath;
  final String title;
  final String body;
  final bool isRight;

  const _ResponsiveStepWidget(
      {required this.assetPath,
      required this.title,
      required this.body,
      this.isRight = true});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRight ? TextDirection.rtl : TextDirection.ltr,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          if (isMobile) {
            return _buildMobileLayout(context, isRight);
          } else {
            return _buildWebLayout(context, isRight);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isRight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(
                        assetPath,
                      ),
                      fit: BoxFit.contain))),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
            child: _buildTextContent(context, isRight),
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, bool isRight) {
    return Container(
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 40.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                            assetPath,
                          ),
                          fit: BoxFit.contain))),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 64.0,
                  right: 32.0,
                  top: 48.0,
                  bottom: 48.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextContent(context, isRight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, bool isRight) {
    return Column(
      crossAxisAlignment:
          isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: isRight ? TextAlign.end : null,
          style: AppFont(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        const SizedBox(height: 25),
        Text(
          body,
          textAlign: isRight ? TextAlign.end : null,
          style: AppFont(
            color: Colors.white70,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
