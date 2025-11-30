import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool notification = true.obs;
  RxBool theme = true.obs;
  void notificationSwitch( bool value) {
    notification.value = !notification.value;
  }
  void themeSwitch( bool value) {
    theme.value = !theme.value;
  }

}