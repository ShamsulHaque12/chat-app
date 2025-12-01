import 'package:get/get.dart';

import '../widgets/call_list.dart';
import '../widgets/group_list.dart';

class ContractListController extends GetxController {
  RxInt selectedIndex = 0.obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  final screens = [
    CallList(),
    GroupList(),
  ];
}