import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../configs/app_font.dart';

class ContactWidgetTextfield extends StatelessWidget {
  final String label;
  final int maxLines;
  final String? initialValue;
  final String? errorMessage;
  final TextEditingController controller;
  final bool isDigits;

  const ContactWidgetTextfield({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.initialValue,
    this.errorMessage,
    this.isDigits = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF4EFE6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black87, width: 2)),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            initialValue: initialValue,
            maxLines: maxLines,
            inputFormatters: isDigits
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            keyboardType: isDigits ? TextInputType.number : null,
            style: AppFont(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: AppFont(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
        if (errorMessage != null)
          Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(errorMessage!,
                  style:
                      AppFont(color: Colors.red, fontWeight: FontWeight.w600)))
      ],
    );
  }
}
