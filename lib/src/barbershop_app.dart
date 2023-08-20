import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop_app/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop_app/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) => MaterialApp(
        title: 'DW Barbershop',
        navigatorObservers: [asyncNavigatorObserver],
        routes: {
          '/': (_) => const SplashPage(),
          '/auth/login': (_) => const LoginPage(),
        },
      ),
    );
  }
}
