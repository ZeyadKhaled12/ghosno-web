import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/core/bloc/cart/cart_bloc.dart';
import 'package:ghosno/core/local/local_pref.dart';
import 'package:ghosno/core/utils/enums.dart';
import 'package:ghosno/core/utils/general_functions/g_fun_valid.dart';
import 'package:ghosno/core/utils/general_widgets/g_widget_loading.dart';
import 'package:ghosno/features/checkout/data/models/calculate_result_model.dart';
import 'package:ghosno/features/checkout/data/models/city_model.dart';
import 'package:ghosno/features/checkout/data/models/create_order_model/create_order_model.dart';
import 'package:ghosno/features/checkout/data/models/create_order_model/customer.dart';
import 'package:ghosno/features/checkout/data/models/create_order_model/order_details.dart';
import 'package:ghosno/features/checkout/data/models/create_order_model/shipping.dart';
import 'package:ghosno/features/checkout/domain/usecases/calculate_uc.dart';
import 'package:ghosno/features/checkout/domain/usecases/create_order_uc.dart';
import 'package:ghosno/features/checkout/presentation/controller/checkout_bloc.dart';
import 'package:ghosno/features/checkout/presentation/screens/order_complete_scr.dart';
import 'package:ghosno/features/checkout/presentation/widgets/checkout_widget_dropdown.dart';
import 'package:ghosno/features/home/data/models/product_model.dart';

import '../../../../configs/app_font.dart';
import 'checkout_widget_textfield.dart';

class CheckoutWidgetFrom extends StatefulWidget {
  const CheckoutWidgetFrom(
      {super.key,
      required this.isMobile,
      required this.citiesLoading,
      required this.cities,
      required this.productModel,
      required this.quantity,
      required this.calculateResultModel,
      required this.createOrderLoading});
  final bool isMobile;
  final bool citiesLoading;
  final List<CityModel> cities;
  final ProductModel productModel;
  final CalculateResultModel calculateResultModel;
  final bool createOrderLoading;
  final int quantity;

  @override
  State<CheckoutWidgetFrom> createState() => _CheckoutWidgetFromState();
}

class _CheckoutWidgetFromState extends State<CheckoutWidgetFrom> {
  bool _saveInfo = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _apartment = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  CityModel? _selectedCity;

  String? _emailErrorMsg;
  String? _lastNameErrorMsg;
  String? _addressErrorMsg;
  String? _cityErrorMsg;
  String? _phoneErrorMsg;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() {
    final CreateOrderModel? createOrderModel = LocalPref.getOrderUserDetail();
    if (createOrderModel != null) {
      _email.text = createOrderModel.customer.email;
      _phone.text = createOrderModel.customer.phone;
      _firstName.text = createOrderModel.customer.firstName ?? '';
      _lastName.text = createOrderModel.customer.lastName;
      _selectedCity = CityModel(id: createOrderModel.shipping.cityId);
      _address.text = createOrderModel.shipping.address;
      _apartment.text = createOrderModel.shipping.apartmentSuite ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double internalSpacing = 12.0;
    double blockSpacing = 28.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact',
            style: AppFont(
              fontSize: 23,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: internalSpacing),
        CheckoutWidgetTextfield(
            controller: _email, labelText: 'Email', errorMsg: _emailErrorMsg),
        SizedBox(height: blockSpacing),
        Text('Delivery',
            style: AppFont(
              fontSize: 23,
              fontWeight: FontWeight.w800,
            )),
        SizedBox(height: internalSpacing),
        CheckoutWidgetDropdown(
            labelText: 'Country/Region',
            items: [CityModel(id: 1, cityName: 'Egypt')],
            onChanged: (value) {},
            selectedValue: CityModel(id: 1, cityName: 'Egypt')),
        SizedBox(height: internalSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: CheckoutWidgetTextfield(
                    controller: _firstName,
                    labelText: 'First name (optional)')),
            SizedBox(width: internalSpacing),
            Expanded(
                child: CheckoutWidgetTextfield(
                    controller: _lastName,
                    labelText: 'Last name',
                    errorMsg: _lastNameErrorMsg)),
          ],
        ),
        SizedBox(height: internalSpacing),
        CheckoutWidgetTextfield(
            controller: _address,
            labelText: 'Address',
            errorMsg: _addressErrorMsg),
        SizedBox(height: internalSpacing),
        CheckoutWidgetTextfield(
            controller: _apartment,
            labelText: 'Apartment, suite, etc. (optional)'),
        SizedBox(height: internalSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: CheckoutWidgetTextfield(
                    controller: _city,
                    labelText: 'City',
                    errorMsg: _cityErrorMsg)),
            SizedBox(width: internalSpacing),
            Expanded(
                child: BlocConsumer<CheckoutBloc, CheckoutState>(
              listener: (context, state) {
                if (state.getCitiesRequestState == RequestState.loaded) {
                  if (_selectedCity?.id != null) {
                    _selectedCity = state.cities.firstWhere(
                        (element) => element.id == _selectedCity?.id);
                  } else {
                    _selectedCity = state.cities.firstOrNull;
                  }

                  if (_selectedCity?.id != null &&
                      widget.productModel.id != null) {
                    context.read<CheckoutBloc>().add(CalculateEvent(
                        calculateParameters: CalculateParameters(
                            productID: widget.productModel.id!,
                            cityID: _selectedCity!.id!,
                            promoCode:
                                context.read<CheckoutBloc>().state.promoCode,
                            quantity: widget.quantity)));
                  }
                }
              },
              listenWhen: (previous, current) =>
                  previous.getCitiesRequestState !=
                  current.getCitiesRequestState,
              builder: (context, state) {
                return CheckoutWidgetDropdown(
                    loading: widget.citiesLoading,
                    selectedValue: _selectedCity,
                    labelText: 'Governorate',
                    items: widget.cities,
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                      if (_selectedCity?.id != null &&
                          widget.productModel.id != null) {
                        context.read<CheckoutBloc>().add(CalculateEvent(
                            calculateParameters: CalculateParameters(
                                productID: widget.productModel.id!,
                                cityID: _selectedCity!.id!,
                                promoCode: context
                                    .read<CheckoutBloc>()
                                    .state
                                    .promoCode,
                                quantity: widget.quantity)));
                      }
                    });
              },
            )),
          ],
        ),
        SizedBox(height: internalSpacing),
        CheckoutWidgetTextfield(
            controller: _phone,
            labelText: 'Phone',
            isDigits: true,
            prefix: Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey.withValues(alpha: .5),
                  ),
                ],
              ),
            ),
            errorMsg: _phoneErrorMsg),
        const SizedBox(height: 4),
        Row(
          children: [
            SizedBox(
              width: 24,
              child: Checkbox(
                value: _saveInfo,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _saveInfo = v ?? false),
              ),
            ),
            const SizedBox(width: 8),
            Text('Save this information for next time',
                style: AppFont(fontSize: 14, color: Colors.black87)),
          ],
        ),
        SizedBox(height: blockSpacing),
        Text('Shipping method',
            style: AppFont(fontSize: 20, fontWeight: FontWeight.w800)),
        SizedBox(height: internalSpacing),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            color: AppColors.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Standard Shipping',
                  style: AppFont(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('LE 65.00',
                  style: AppFont(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: blockSpacing),
        Text('Payment',
            style: AppFont(fontSize: 23, fontWeight: FontWeight.w800)),
        Text('All transactions are secure and encrypted.',
            style: AppFont(color: Colors.grey, fontSize: 13)),
        SizedBox(height: internalSpacing),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            color: AppColors.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('Cash on Delivery (COD)',
              style: AppFont(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 40),
        BlocConsumer<CheckoutBloc, CheckoutState>(
            listener: (context, state) async {
              if (state.createOrderRequestState == RequestState.loaded) {
                await LocalPref.setCart(0, ProductModel());
                context.read<CartBloc>().add(UpdateCartEvent());
                Navigator.pushReplacementNamed(context, OrderCompleteScr.route);
              }
            },
            listenWhen: (previous, current) =>
                previous.createOrderRequestState !=
                current.createOrderRequestState,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () async {
                    String phone = _phone.text;

                    setState(() {
                      _emailErrorMsg = null;
                      _lastNameErrorMsg = null;
                      _addressErrorMsg = null;
                      _cityErrorMsg = null;
                      _phoneErrorMsg = null;
                    });
                    if (_email.text.isEmpty) {
                      _emailErrorMsg = 'Enter an email';
                    } else {
                      if (!GFunValid.isValidEmail(_email.text)) {
                        _emailErrorMsg = 'Enter a valid email';
                      }
                    }
                    if (_lastName.text.isEmpty) {
                      _lastNameErrorMsg = 'Enter a last name';
                    }
                    if (_address.text.isEmpty) {
                      _addressErrorMsg = 'Enter an address';
                    }
                    if (_city.text.isEmpty) {
                      _cityErrorMsg = 'Enter a city';
                    }
                    if (_phone.text.isEmpty) {
                      _phoneErrorMsg = 'Enter a phone number';
                    } else {
                      if (!phone.startsWith('0')) {
                        phone = '0$phone';
                      }
                      if (!GFunValid.isValidEgyptianPhone(phone)) {
                        _phoneErrorMsg = 'Enter a valid phone number';
                      }
                    }
                    setState(() {});
                    if (_emailErrorMsg != null ||
                        _lastNameErrorMsg != null ||
                        _addressErrorMsg != null ||
                        _cityErrorMsg != null ||
                        _phoneErrorMsg != null) {
                      return;
                    }
                    if (widget.productModel.id != null) {
                      CreateOrderModel createOrderModel = CreateOrderModel(
                          customer: Customer(
                              email: _email.text,
                              phone: phone,
                              lastName: _lastName.text,
                              firstName: _firstName.text.isEmpty
                                  ? null
                                  : _firstName.text),
                          shipping: Shipping(
                            cityId: _selectedCity!.id!,
                            address: _address.text,
                            apartmentSuite: _apartment.text.isEmpty
                                ? null
                                : _apartment.text,
                          ),
                          orderDetails: OrderDetails(
                              productId: widget.productModel.id!,
                              quantity: widget.quantity,
                              promoCode: (context
                                          .read<CheckoutBloc>()
                                          .state
                                          .promoCode
                                          ?.isEmpty ??
                                      true)
                                  ? null
                                  : context
                                      .read<CheckoutBloc>()
                                      .state
                                      .promoCode));
                      if (_saveInfo) {
                        await LocalPref.setOrderUserDetail(createOrderModel);
                      }
                      context.read<CheckoutBloc>().add(CreateOrderEvent(
                          createOrderParameters: CreateOrderParameters(
                              createOrderModel: createOrderModel)));
                    }
                  },
                  child: widget.createOrderLoading
                      ? GWidgetLoadingCircle(
                          color: Colors.white,
                          strokeWidth: 2.8,
                          height: 24,
                          width: 24)
                      : Text('Complete order',
                          style: AppFont(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                ),
              );
            })
      ],
    );
  }
}
