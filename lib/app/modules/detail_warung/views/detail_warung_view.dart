import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detail_warung_controller.dart';

class DetailWarungView extends GetView<DetailWarungController> {
  DetailWarungView({Key? key}) : super(key: key);

  final Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nameC.text = data["name"];
    controller.locationC.text =
        "${data["location"]["lat"]}, ${data["location"]["long"]}";
    controller.addressC.text = data["address"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Warung'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Container(
              height: 150,
              width: 100,
              child: Image.network(
                data["profile"],
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 20,
          ),
          TextField(
            showCursor: false,
            maxLength: 50,
            enabled: false,
            controller: controller.nameC,
            decoration: InputDecoration(
                label: Text('Nama Warung'), border: OutlineInputBorder()),
          ),
          TextField(
            controller: controller.locationC,
            showCursor: false,
            enabled: false,
            decoration: InputDecoration(
                label: Text('Korrdinat'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.addressC,
            showCursor: false,
            enabled: false,
            maxLines: 6,
            maxLength: 1000,
            decoration: InputDecoration(
                label: Text('Alamat'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.EDIT_WARUNG, arguments: data),
        child: Icon(
          Icons.edit,
          size: 35,
        ),
      ),
    );
  }
}
