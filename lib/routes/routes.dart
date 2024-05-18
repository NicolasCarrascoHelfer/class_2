import 'package:flutter/material.dart';

import 'package:practica_2/screens/screens.dart';

class AppRouting {
  static const initialRoute = 'onBoardingScreen';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoute = {};

    appRoute.addAll({
      "onBoardingScreen": (BuildContext context) => const OnBoardingScreen()
    });
    appRoute
        .addAll({"homeScreen": (BuildContext context) => const HomeScreen()});
    appRoute.addAll(
        {"productScreen": (BuildContext context) => const ProductScreen()});

    return appRoute;
  }
}
