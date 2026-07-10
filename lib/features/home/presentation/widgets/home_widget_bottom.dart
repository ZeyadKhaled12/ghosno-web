import 'package:flutter/material.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/features/home/presentation/screens/privacy_policy_scr.dart';
import 'package:ghosno/features/home/presentation/screens/terms_conditions_scr.dart';

class HomeWidgetBottom extends StatelessWidget {
  const HomeWidgetBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.only(
          top: 40.0, bottom: 24.0, left: 16.0, right: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.facebook),
                  const SizedBox(width: 16),
                  _buildSocialIcon(Icons.camera_alt_outlined),
                ],
              ),
              const SizedBox(height: 32),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
              ),
              const SizedBox(height: 32),
              if (isMobile)
                _buildMobileLinks(context)
              else
                _buildWebLinks(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildWebLinks(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _widgets(isMobile: true, context: context));
  }

  List<Widget> _widgets(
      {required BuildContext context, bool isMobile = false}) {
    return [
      _FooterText('© 2026 Ghosno. All rights reserved.'),
      _FooterDotSpacer(isMobile: isMobile),
      _FooterLink('Privacy policy', () async {
        if (ModalRoute.of(context)?.settings.name == PrivacyPolicyScr.route) {
          return;
        }
        await Navigator.pushNamed(context, PrivacyPolicyScr.route);
      }),
      _FooterDotSpacer(isMobile: isMobile),
      _FooterLink('Terms of service', () async {
        if (ModalRoute.of(context)?.settings.name == TermsConditionsScr.route) {
          return;
        }
        await Navigator.pushNamed(context, TermsConditionsScr.route);
      }),
    ];
  }

  Widget _buildMobileLinks(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        runSpacing: 12.0,
        children: _widgets(isMobile: true, context: context));
  }
}

class _FooterText extends StatelessWidget {
  final String text;
  const _FooterText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const _FooterLink(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _FooterDotSpacer extends StatelessWidget {
  final bool isMobile;
  const _FooterDotSpacer({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 4.0 : 8.0),
      child: const Text(
        '·',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
