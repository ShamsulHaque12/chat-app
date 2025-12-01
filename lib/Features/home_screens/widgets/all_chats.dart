import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../view/personal_message.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: SpinKitWave(
            color: Colors.green,
            size: 40.0,
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.story.length,
        itemBuilder: (context, index) {
          final story = controller.story[index];

          return GestureDetector(
            onTap: () {
              Get.to(() => PersonalMessage(
                name: story.name,
                image: story.imagePath,
              ));
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              color: isDark ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(
                  color: Colors.green,
                  width: 1.0,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                leading: CircleAvatar(
                  radius: 26.r,
                  backgroundImage: AssetImage(story.imagePath),
                ),
                title: Text(
                  story.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  "Tap to open chat",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
