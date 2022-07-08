import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';

class EditWarungController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController locationC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController latC = TextEditingController();
  TextEditingController longC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final ImagePicker imagePicker = ImagePicker();

  XFile? image = null;

  void pickerImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.name.split(".").last);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  void editWarung(String uid) async {
    if (nameC.text.isNotEmpty &&
        locationC.text.isNotEmpty &&
        addressC.text.isNotEmpty) {
      //Berhasil Buat Akun
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
          "location": {
            "lat": latC.text,
            "long": longC.text,
          },
          "address": addressC.text,
          "updated_at": DateTime.now().toIso8601String(),
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$uid/profile.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();
          data.addAll({"profile": urlImage});
        }
        await firestore.collection("warung").doc(uid).update(data);
        print("suskses");
        Get.offAllNamed(Routes.HOME);
        Get.snackbar("Sukses", "Sukses Edit warung");
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
        Get.snackbar("Terjadi kesalahan", "Tidak bisa edit warung!");
        print(e);
        print(uid);
      }
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "Nip, nama, dan email anda harus diisi");
    }
    print(nameC.text);
    print(locationC.text);
    print(addressC.text);
  }

  void getLocation() async {
    Map<String, dynamic> dataResponse = await determinePosition();
    if (dataResponse["error"] != true) {
      Position position = dataResponse["position"];
      print("${position.latitude} - ${position.longitude}");
      Get.snackbar("Berhasil", dataResponse["message"]);
      latC.text = position.latitude.toString();
      longC.text = position.longitude.toString();
      locationC.text = "${position.latitude} , ${position.longitude}";
    } else {
      Get.snackbar("Terjadi Kesalahan", dataResponse["message"]);
    }
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        "message": "Tidak dapat mengambil GPS dari device ini",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message": "Izin menggunakan GPS ditolak",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message": "Silahkan cek GPS kamu, aktifkan GPS di settingan HP kamu",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "Berhasil mendapatkan location",
      "error": false,
    };
  }
}
