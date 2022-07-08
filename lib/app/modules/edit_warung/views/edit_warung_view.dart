import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_warung_controller.dart';

class EditWarungView extends GetView<EditWarungController> {
  const EditWarungView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Get.arguments;
    controller.nameC.text = data["name"];
    controller.locationC.text =
        "${data["location"]["lat"]}, ${data["location"]["long"]}";
    controller.addressC.text = data["address"];
    controller.latC.text = data["location"]["lat"];
    controller.longC.text = data["location"]["long"];
    print(data);
    return Scaffold(
        appBar: AppBar(
          title: const Text('EditWarungView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            GetBuilder<EditWarungController>(builder: (controller) {
              if (controller.image != null) {
                return InkWell(
                  onTap: () {
                    controller.pickerImage();
                  },
                  child: Container(
                    height: 150,
                    width: 100,
                    child: data["profile"] != null
                        ? Image.network(
                            data["profile"],
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(controller.image!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    controller.pickerImage();
                  },
                  child: Container(
                    height: 150,
                    width: 100,
                    color: Colors.grey,
                    child: data["profile"] != null
                        ? Image.network(
                            data["profile"],
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text('Klik untuk upload image'),
                          ),
                  ),
                );
              }
            }),
            SizedBox(
              height: 20,
            ),
            TextField(
              showCursor: false,
              maxLength: 50,
              controller: controller.nameC,
              decoration: InputDecoration(
                  label: Text('Nama Warung'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.locationC,
                    showCursor: false,
                    enabled: false,
                    decoration: InputDecoration(
                        label: Text('Korrdinat'), border: OutlineInputBorder()),
                  ),
                ),
                IconButton(
                    onPressed: () => controller.getLocation(),
                    icon: Icon(Icons.location_pin)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.addressC,
              showCursor: false,
              maxLines: 6,
              maxLength: 1000,
              decoration: InputDecoration(
                  label: Text('Alamat'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                controller.editWarung(data["uid"]);
              },
              child: Text('Submit'),
            ),
          ],
        ));
  }
}
