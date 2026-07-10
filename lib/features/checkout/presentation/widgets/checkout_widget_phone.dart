import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../configs/app_colors.dart';
import '../../../../configs/app_font.dart';

class CheckoutWidgetPhone extends StatefulWidget {
  const CheckoutWidgetPhone({
    super.key,
    this.controller,
    required this.labelText,
  });

  final TextEditingController? controller;
  final String labelText;

  @override
  State<CheckoutWidgetPhone> createState() => _CheckoutWidgetPhoneState();
}

class _CheckoutWidgetPhoneState extends State<CheckoutWidgetPhone> {
  bool _isFocused = false;
  String? _errorText;

  void _validatePhoneNumber(String value) {
    final regex = RegExp(r'^01[0125][0-9]{8}$');

    setState(() {
      if (value.isEmpty) {
        _errorText = null;
      } else if (!regex.hasMatch(value)) {
        _errorText = 'Please enter a valid Egyptian phone number';
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
              if (!hasFocus && widget.controller != null) {
                _validatePhoneNumber(widget.controller!.text);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _errorText != null
                    ? Colors.red
                    : _isFocused
                        ? AppColors.primary
                        : Colors.grey.withValues(alpha: .5),
                width: _isFocused || _errorText != null ? 2.0 : 1.0,
              ),
            ),
            child: TextField(
              controller: widget.controller,
              cursorColor: Colors.black,
              style: AppFont(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              onChanged: (value) {
                if (_errorText != null && value.length == 11) {
                  _validatePhoneNumber(value);
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: widget.labelText,
                labelStyle: AppFont(
                  color: _errorText != null
                      ? Colors.red
                      : Colors.black.withValues(alpha: .69),
                ),
                // --- NEW CODE: Adds the Flag and +20 ---
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Keeps the row from taking the whole width
                    children: [
                      Text(
                        '+20',
                        style: AppFont(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // A nice vertical line to separate the prefix from the input
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.grey.withValues(alpha: .5),
                      ),
                    ],
                  ),
                ),
                // ---------------------------------------
              ),
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10.0),
            child: Text(
              _errorText!,
              style: AppFont(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
