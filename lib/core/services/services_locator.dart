import 'package:get_it/get_it.dart';
import 'package:ghosno/core/bloc/cart/cart_bloc.dart';
import 'package:ghosno/features/checkout/data/datasource/checkout_remote_data_source.dart';
import 'package:ghosno/features/checkout/data/repository/checkout_repo.dart';
import 'package:ghosno/features/checkout/domain/repository/base_checkout_repo.dart';
import 'package:ghosno/features/checkout/domain/usecases/calculate_uc.dart';
import 'package:ghosno/features/checkout/domain/usecases/create_order_uc.dart';
import 'package:ghosno/features/checkout/domain/usecases/get_cities_uc.dart';
import 'package:ghosno/features/checkout/presentation/controller/checkout_bloc.dart';
import 'package:ghosno/features/home/data/datasource/home_remote_data_source.dart';
import 'package:ghosno/features/home/data/repository/home_repo.dart';
import 'package:ghosno/features/home/domain/repository/base_home_repo.dart';
import 'package:ghosno/features/home/domain/usecases/add_to_cart_uc.dart';
import 'package:ghosno/features/home/domain/usecases/buy_uc.dart';
import 'package:ghosno/features/home/domain/usecases/get_products_uc.dart';
import 'package:ghosno/features/home/presentation/controller/home_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // Bloc
    sl.registerFactory(() => HomeBloc(sl(), sl(), sl()));
    sl.registerFactory(() => CartBloc());
    sl.registerFactory(() => CheckoutBloc(sl(), sl(), sl()));

    // home usecases
    sl.registerLazySingleton(() => GetProductsUc(sl()));
    sl.registerLazySingleton(() => AddToCartUc(sl()));
    sl.registerLazySingleton(() => BuyUc(sl()));

    //checkout usecases
    sl.registerLazySingleton(() => GetCitiesUc(sl()));
    sl.registerLazySingleton(() => CalculateUc(sl()));
    sl.registerLazySingleton(() => CreateOrderUc(sl()));

    // Repo
    sl.registerLazySingleton<BaseHomeRepo>(() => HomeRepo(sl()));
    sl.registerLazySingleton<BaseCheckoutRepo>(() => CheckoutRepo(sl()));

    // Data Source
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
        () => HomeRemoteDataSource());
    sl.registerLazySingleton<BaseCheckoutRemoteDataSource>(
        () => CheckoutRemoteDataSource());
  }
}
