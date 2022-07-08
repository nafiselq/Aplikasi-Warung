import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_apps/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Warung'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamAllWarung(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
              return SizedBox(
                height: 150,
                child: Center(
                  child: Text("Belum ada Warung"),
                ),
              );
            }

            return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data!.docs[index].data();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () =>
                            Get.toNamed(Routes.DETAIL_WARUNG, arguments: data),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 100,
                                child: Image.network(
                                  "${data["profile"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 150,
                                        child: Text('${data["name"]}')),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 150,
                                        child: Text('${data["address"]}')),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 150,
                                      child: Text(
                                          '${data["location"]["lat"]}, ${data["location"]["long"]}'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.REGISTER),
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
