import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:socket/login_page.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: "Socket",
      home: const LoginPage()));
}
