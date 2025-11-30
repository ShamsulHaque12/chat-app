import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Features/bottom_nav_bar/screens/bottom_nav_bar_screen.dart';
import 'Features/home_screens/view/home_screen.dart';
import 'Features/profile_screens/controller/theme_controller.dart';
import 'auth/views/login_screen.dart';

final ThemeController themeController = Get.put(ThemeController());
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void configEasyLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = Colors.white
      ..indicatorColor = Colors.white
      ..maskColor = Colors.green
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.themeMode.value,
        title: 'Chat App',
        home: BottomNavBarScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
