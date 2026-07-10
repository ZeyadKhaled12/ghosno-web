import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/configs/app_font.dart';

class CheckoutWidgetTextfield extends StatefulWidget {
  const CheckoutWidgetTextfield(
      {super.key,
      this.controller,
      required this.labelText,
      this.errorMsg,
      this.isDigits = false,
      this.prefix,
      this.suffix});
  final TextEditingController? controller;
  final String labelText;
  final String? errorMsg;
  final bool isDigits;
  final Widget? prefix;
  final Widget? suffix;

  @override
  State<CheckoutWidgetTextfield> createState() =>
      _CheckoutWidgetTextfieldState();
}

class _CheckoutWidgetTextfieldState extends State<CheckoutWidgetTextfield> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.errorMsg != null
                    ? Colors.red
                    : _isFocused
                        ? AppColors.primary
                        : Colors.grey.withValues(alpha: .5),
                width: _isFocused || widget.errorMsg != null ? 2.0 : 1.0,
              ),
            ),
            child: TextField(
              controller: widget.controller,
              cursorColor: Colors.black,
              inputFormatters: widget.isDigits
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : null,
              keyboardType: widget.isDigits ? TextInputType.number : null,
              style: AppFont(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: widget.labelText,
                  labelStyle:
                      AppFont(color: Colors.black.withValues(alpha: .69)),
                  prefixIcon: widget.prefix,
                  suffixIcon: widget.suffix),
            ),
          ),
        ),
        if (widget.errorMsg != null)
          Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(widget.errorMsg!,
                  style:
                      AppFont(color: Colors.red, fontWeight: FontWeight.w500)))
      ],
    );
  }
}
