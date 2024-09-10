import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_note/const/app_colors.dart';
import 'package:keep_note/controller_bindings.dart';
import 'package:keep_note/routes/app_routes.dart';

class KeepNote extends StatelessWidget {
  const KeepNote({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Keep Note',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColor),
        useMaterial3: true,
      ),
      initialBinding: ControllerBindings(),
      routerDelegate: goRouter.routerDelegate,
      backButtonDispatcher: goRouter.backButtonDispatcher,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
    );
  }
}
