import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soundify/core/binding/app_binding.dart';
import 'package:soundify/core/routes/app_routes.dart';
import 'package:soundify/modules/bottom_nav_bar/views/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBinding(),
          getPages: AppRoutes.pages,
          initialRoute: AppRoutes.bottomNavBar,
          home: BottomNavBar(),
        );
      },
    );
  }
}
