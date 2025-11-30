import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../contract_list/screens/contract_list.dart';
import '../../profile_screens/screens/profile_screen.dart';
import '../../home_screens/view/home_screen.dart';
import '../controller/bottom_nav_bar_controller.dart';

class BottomNavBarScreen extends StatelessWidget {
  final BottomNavBarController controller = Get.put(BottomNavBarController());

  BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<Widget> screens = [HomeScreen(), ContractList(), ProfileScreen()];

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: Obx(() => screens[controller.isselectedIndex.value]),
        bottomNavigationBar: Container(
          height: 55.h,
          margin: EdgeInsets.only(bottom: 16.h, left: 12.w, right: 12.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.06),
                blurRadius: 6,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navItem(
                  icon: Icons.home,
                  title: "Home",
                  index: 0,
                  isDark: isDark,
                ),
                navItem(
                  icon: Icons.list,
                  title: "Contract",
                  index: 1,
                  isDark: isDark,
                ),
                navItem(
                  icon: Icons.person_2,
                  title: "Profile",
                  index: 2,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem({
    required IconData icon,
    required String title,
    required int index,
    required bool isDark,
  }) {
    bool isSelected = controller.isselectedIndex.value == index;

    final Color activeColor = Colors.green;
    final Color inactiveColor = isDark ? Colors.white70 : Colors.black54;

    return GestureDetector(
      onTap: () {
        controller.isselectedIndex.value = index;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 14.w : 10.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            AnimatedScale(
              scale: isSelected ? 1.3 : 1.0,
              duration: Duration(milliseconds: 250),
              child: Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: isSelected ? 26.sp : 24.sp,
              ),
            ),
            SizedBox(width: isSelected ? 6.w : 0),
            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: isSelected
                  ? Text(
                      title,
                      style: TextStyle(
                        color: activeColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
