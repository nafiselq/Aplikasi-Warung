import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/register_user_controller.dart';

class RegisterUserView extends GetView<RegisterUserController> {
  const RegisterUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER PAGE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          TextField(
            showCursor: false,
            controller: controller.emailC,
            decoration: InputDecoration(
                label: Text('Email Address'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            showCursor: false,
            obscureText: true,
            controller: controller.passwordC,
            decoration: InputDecoration(
                label: Text('Password'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            showCursor: false,
            obscureText: true,
            controller: controller.password2C,
            decoration: InputDecoration(
                label: Text('Password Confirm'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text("Sudah punya akun ? Silahkan"),
              TextButton(
                  onPressed: () => Get.offAllNamed(Routes.LOGIN),
                  child: Text('Login'))
            ],
          ),
          ElevatedButton(
            onPressed: () {
              controller.addUser();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
