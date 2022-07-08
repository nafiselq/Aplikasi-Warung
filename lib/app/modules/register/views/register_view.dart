import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah/Edit Warung'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          GetBuilder<RegisterController>(builder: (controller) {
            if (controller.image != null) {
              return InkWell(
                onTap: () {
                  controller.pickerImage();
                },
                child: Container(
                  height: 150,
                  width: 100,
                  child: Image.file(
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
                  child: Center(
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
              controller.addWarung();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
