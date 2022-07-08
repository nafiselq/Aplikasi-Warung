import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence_apps/app/routes/app_pages.dart';

class RegisterUserController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController password2C = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addUser() async {
    if (emailC.text.isNotEmpty &&
        passwordC.text.isNotEmpty &&
        password2C.text.isNotEmpty) {
      //Berhasil Buat Akun
      if (password2C.text.contains(passwordC.text)) {
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
                  email: emailC.text, password: passwordC.text);
          if (userCredential.user != null) {
            String uid = userCredential.user!.uid;
            await firestore.collection("user").doc(uid).set({
              "email": emailC.text,
              "password": passwordC.text,
              "uid": uid,
              "created_at": DateTime.now().toIso8601String(),
            });

            await userCredential.user!.sendEmailVerification();
          }
          print(userCredential);
          Get.snackbar("Sukses", "Berhasil Buat User");
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            // print('Password terlalu pendek!.');
            Get.snackbar("Terjadi kesalahan", "Password terlalu singkat!");
          } else if (e.code == 'email-already-in-use') {
            // print('Email tersebut sudah pernah register');
            Get.snackbar(
                "Terjadi kesalahan", "Email tersebut sudah pernah mendaftar!");
          }
        } catch (e) {
          Get.snackbar("Terjadi kesalahan", "Tidak bisa tambah pegawai!");
        }
      } else {
        Get.snackbar("Terjadi Kesalahan", "Konfirmasi password tidak sama");
      }
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "Nip, nama, dan email anda harus diisi");
    }
    print(emailC.text);
  }
}
