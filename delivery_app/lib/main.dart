import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/pages/food/popular_food_details.dart';
import 'package:delivery_app/pages/food/recommended_food_detail.dart';
import 'package:delivery_app/pages/home/body_food_page.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}


