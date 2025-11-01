import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goatscave/core/core.dart';

import 'package:goatscave/features/food/food.dart';

void main() {
  runApp(const GoatsCaveApp());
}

class GoatsCaveApp extends StatelessWidget {
  const GoatsCaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            // BlocProvider<CartBloc>(
            //     create: (context) => CartBloc(),
            //  ),
            BlocProvider<FoodBloc>(
              create: (context) => FoodBloc(),
            ),
            // We'll add more BLoCs as we build them:
            // BlocProvider<TaxiBloc>(create: (context) => TaxiBloc()),
            // BlocProvider<GroceryBloc>(create: (context) => GroceryBloc()),
            // BlocProvider<BusBloc>(create: (context) => BusBloc()),
          ],
          child: MaterialApp.router(
            title: 'GoatsCave',
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
          ),
        );
      },
    );
  }
}
