import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/configs/app_colors.dart';
import 'package:ghosno/core/bloc/cart/cart_bloc.dart';
import 'package:ghosno/features/checkout/presentation/screens/order_complete_scr.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/local/local_pref.dart';
import 'core/services/services_locator.dart';
import 'features/checkout/presentation/screens/checkout_scr.dart';
import 'features/home/presentation/screens/home_scr.dart';
import 'features/home/presentation/screens/privacy_policy_scr.dart';
import 'features/home/presentation/screens/terms_conditions_scr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  LocalPref.sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<CartBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ghosno',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          routes: {
            '/': (context) => HomeScr(),
            HomeScr.route: (context) => HomeScr(),
            OrderCompleteScr.route: (context) => OrderCompleteScr(),
            PrivacyPolicyScr.route: (context) => PrivacyPolicyScr(),
            TermsConditionsScr.route: (context) => TermsConditionsScr(),
            CheckoutScr.route: (context) => CheckoutScr()
          },
        ));
  }
}
