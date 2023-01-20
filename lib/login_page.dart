import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket/landing_page.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  var uuid = Uuid();
// var v1 = uuid.v1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket.io"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Who are you?"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 120,
              height: 35,
              child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.redAccent,
                  constraints: BoxConstraints.tightFor(width: 100, height: 50),
                  onPressed: () {
                    if (_usernameController.text.isNotEmpty) {
                      Get.to(LandingPage(
                        username: _usernameController.text,
                        userid: uuid.v1(),
                      ));
                      _usernameController.clear();
                    }
                  },
                  child: Text("Start now")),
            ),
          ],
        ),
      ),
    );
  }
}
