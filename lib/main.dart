import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/commons/utils/util_colors.dart';
import 'package:flutter_clean_architecture/presentation/photos/view/photos_view.dart';
import 'package:flutter_clean_architecture/presentation/photos/viewModel/photos_controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //primarySwatch: UtilColors.primaryColor,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: UtilColors.primaryColor,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'NotoSans',
      ),
      initialBinding: BindingsBuilder.put(() => PhotosController()),
      home: const PhotosView(),
    );
  }
}



