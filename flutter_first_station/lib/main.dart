import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_station/navigation/app_navigation.dart';
import 'package:flutter_first_station/values/colors.dart';
import 'package:flutter_first_station/values/sizes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          //输入框样式
          filled: true, //是否填充
          fillColor: ThemeColors.bgColor, //填充色
          hintStyle: TextStyle(color: ThemeColors.hintColor), //提示文字样式
          border: OutlineInputBorder(
            //边框样式
            borderSide: BorderSide.none, //边框颜色
            borderRadius: Sizes.borderRadius, //圆角
          ),
          focusedBorder: OutlineInputBorder(
            //获取焦点时的边框样式
            borderSide: BorderSide.none, //边框颜色
            borderRadius: Sizes.borderRadius, //圆角
          ),
        ),
      ),
      home: const AppNavigation(),
    );
  }
}
