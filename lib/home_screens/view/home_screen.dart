import 'package:chat_app/home_screens/controller/home_controller.dart';
import 'package:chat_app/home_screens/view/personal_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.data.isEmpty && !controller.isLoading.value) {
      controller.message();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen Message"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.data.length,
          itemBuilder: (BuildContext context, int index) {
            final mes = controller.data[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(mes.imagePath),
              ),
              title: Text(mes.name),
              subtitle: Text(mes.membar),
              trailing: ElevatedButton(
                onPressed: () {
                  Get.to(() => PersonalMessage(
                    name: mes.name,
                  ));
                },
                child: Text(mes.button),
              ),
            );
          },
        );
      }),
    );
  }
}
