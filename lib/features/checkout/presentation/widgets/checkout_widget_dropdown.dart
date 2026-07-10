import 'package:flutter/material.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/configs/app_font.dart';
import 'package:ghosno/core/utils/general_widgets/g_widget_loading.dart';

import '../../data/models/city_model.dart';

class CheckoutWidgetDropdown extends StatefulWidget {
  const CheckoutWidgetDropdown(
      {super.key,
      required this.labelText,
      this.selectedValue,
      required this.items,
      required this.onChanged,
      this.loading = false});
  final String labelText;
  final CityModel? selectedValue;
  final List<CityModel> items;
  final bool loading;
  final Function(CityModel value) onChanged;

  @override
  State<CheckoutWidgetDropdown> createState() => _CheckoutWidgetDropdownState();
}

class _CheckoutWidgetDropdownState extends State<CheckoutWidgetDropdown> {
  bool _isFocused = false;

  CityModel? selectedValue;

  @override
  void initState() {
    selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Focus(
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
                color: _isFocused
                    ? AppColors.primary
                    : Colors.grey.withValues(alpha: .5),
                width: _isFocused ? 2.0 : 1.0,
              ),
            ),
            child: DropdownButtonFormField<CityModel>(
              value: widget.selectedValue ?? selectedValue,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: widget.labelText,
                  labelStyle:
                      AppFont(color: Colors.black.withValues(alpha: .69))),
              items: widget.items
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.cityName ?? '', style: AppFont())))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedValue = value;
                  });
                  widget.onChanged(value);
                }
              },
            ),
          ),
        )),
        if (widget.loading)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GWidgetLoadingCircle(
              color: AppColors.primary,
              width: 22,
              height: 22,
              strokeWidth: 2.9,
            ),
          )
      ],
    );
  }
}
