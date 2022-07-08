import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:presence_apps/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isEmpty && passwordC.text.isEmpty) {
      Get.snackbar(
          "Terjadi Kesalahan", "Email dan Password tidak boleh kosong");
    } else {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified != true) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
              title: "Belum Verifikasi",
              middleText: "Kamu belum melakukan verifikasi menggunakan Email",
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi kesalahan", "User tiak ditemukan");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi kesalahan", "Password salah");
          print('Wrong password provided for that user.');
        }
        Get.snackbar("Terjadi kesalahan", "User tidak ditemukan");
      }
    }
  }
}
