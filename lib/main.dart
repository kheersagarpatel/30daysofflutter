import 'package:flutter/material.dart';
import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/pages/cart_page.dart';
import 'package:flutter_catalog/pages/home_detail_page.dart';
import 'package:flutter_catalog/pages/home_page.dart';
import 'package:flutter_catalog/pages/login_page.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    VxState(
      store: MyStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final double pi = 3.14;
  final bool isMale = true;
  final num temp = 30; // contains int and double

  final day = "tuesday";
  final date = 24; // final is final
  static var someStatic = "23sd"; // static requires final

  static const pii = 3.14; // you can't modify this things
  final String somethingList = "you can change final";

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // themeMode: ThemeMode.system,
      themeMode: ThemeMode.dark,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(routes: {
        "/": (_, __) => const MaterialPage(child: LoginPage()),
        MyRoutes.homeRoute: (_, __) => const MaterialPage(child: HomePage()),
        MyRoutes.homeDetailsRoute: (uri, _) {
          final catalog = (VxState.store as MyStore).catalog.getById(int.parse(uri.queryParameters["id"]!));
          return MaterialPage(
              child: HomeDetailPage(
            catalog: catalog,
          ));
        },
        MyRoutes.loginRoute: (_, __) => const MaterialPage(child: LoginPage()),
        MyRoutes.cartRoute: (_, __) => const MaterialPage(child: CartPage()),
      }),
      // initialRoute: MyRoutes.homeRoute,
      // routes: {
      //   "/": (context) => const LoginPage(),
      //   MyRoutes.homeRoute: (context) => const HomePage(),
      //   MyRoutes.loginRoute: (context) => const LoginPage(),
      //   MyRoutes.cartRoute: (context) => const CartPage(),
      // },
    );
  }
}
