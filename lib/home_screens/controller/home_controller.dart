import 'dart:developer';

import 'package:chat_app/home_screens/model/home_model.dart';
import 'package:get/get.dart';

import '../../utills/api_config.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<HomeModel> data = <HomeModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    message();
  }
  void message() {
    data.value = [
      HomeModel(
        id: "1",
        name: "Group 1",
        imagePath: "assets/images/profile.png",
        membar: "2 Member",
        button: "Join",
      ),
      HomeModel(
        id: "2",
        name: "Group 2",
        imagePath: "assets/images/profile.png",
        membar: "2 Member",
        button: "Join",
      ),
      HomeModel(
        id: "3",
        name: "Group 3",
        imagePath: "assets/images/profile.png",
        membar: "2 Member",
        button: "Join",
      ),
    ];
    isLoading.value = false;
  }

  Future<void> joinGroup(String token, String groupId, String userId) async {
    try {
      log("Join Group Api Request ===>${ApiConfig.group}/");

    }catch(e){
      log(e.toString());
    }
  }
}
