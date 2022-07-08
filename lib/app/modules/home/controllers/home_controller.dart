import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence_apps/app/routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllWarung() async* {
    yield* firestore.collection("warung").orderBy("uid").snapshots();
  }
}
