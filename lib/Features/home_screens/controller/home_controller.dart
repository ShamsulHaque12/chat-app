import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utills/api_config.dart';
import '../model/home_model.dart';
import '../widgets/all_chats.dart';
import '../widgets/read_chat.dart';
import '../widgets/unread_chat.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  RxBool isLoading = true.obs;
  RxList<HomeModel> story = <HomeModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    message();
  }

  void message() {
    story.value = [
      HomeModel(
        id: "1",
        name: "Group 1",
        imagePath: "assets/images/profile.png",
      ),
      HomeModel(
        id: "2",
        name: "Group 2",
        imagePath: "assets/images/profile.png",
      ),
      HomeModel(
        id: "3",
        name: "Group 3",
        imagePath: "assets/images/profile.png",
      ),
    ];
    isLoading.value = false;
  }

  RxInt selectedIndex = 0.obs;

  final screens = [
    AllChats(),
    UnreadChat(),
    ReadChat(),
  ];

}
