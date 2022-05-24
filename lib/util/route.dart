
import 'package:get/get.dart';

import '../pages/home/home.dart';
class RouteManager{

  static const String initial = '/initial';

  static String getInitial() => '$initial';

  static List<GetPage> routes = [

    GetPage(name: initial, page: () => const Home())

  ];
}