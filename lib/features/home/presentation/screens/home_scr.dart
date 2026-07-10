import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghosno/core/usecase/base_use_case.dart';
import 'package:ghosno/core/utils/enums.dart';
import 'package:ghosno/features/home/presentation/controller/home_bloc.dart';
import 'package:ghosno/features/home/presentation/widgets/home_body.dart';
import '../../../../core/services/services_locator.dart';

class HomeScr extends StatelessWidget {
  const HomeScr({super.key});
  static const route = '/Home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            sl<HomeBloc>()..add(GetProductsEvent(noParameters: NoParameters())),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return HomeBody(
              productsLoading:
                  state.productsRequestState == RequestState.loading,
              products: state.products,
              productErrorMessage: state.productErrorMessage,
            );
          },
        ));
  }
}
