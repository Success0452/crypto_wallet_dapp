
import 'package:crypto_wallet_dapp/pages/home/controller/home_controller.dart';
import 'package:crypto_wallet_dapp/pages/start/controller/start_controller.dart';
import 'package:crypto_wallet_dapp/util/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeController()),
          ChangeNotifierProvider(create: (context) => StartController()),
        ],
        builder: (context, child){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteManager.getInitial(),
            getPages: RouteManager.routes,
          );
        },
    );
  }
}
