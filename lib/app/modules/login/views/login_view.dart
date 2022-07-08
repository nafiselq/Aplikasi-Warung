import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_apps/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextField(
              controller: controller.emailC,
              showCursor: false,
              decoration: InputDecoration(
                  label: Text('Email Address'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              obscureText: true,
              controller: controller.passwordC,
              showCursor: false,
              decoration: InputDecoration(
                  label: Text('Password'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text("Belum punya akun ? Silahkan"),
                TextButton(
                    onPressed: () => Get.offAllNamed(Routes.REGISTER_USER),
                    child: Text('Daftar'))
              ],
            ),
            ElevatedButton(
              onPressed: () {
                controller.login();
              },
              child: Text("Login"),
            ),
          ],
        ));
  }
}
