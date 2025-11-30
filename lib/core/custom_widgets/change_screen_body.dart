import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangeScreenBody extends StatelessWidget {
  final RxInt selectedIndex;
  final List<Widget> screens;

  const ChangeScreenBody({
    Key? key,
    required this.selectedIndex,
    required this.screens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ---------------------- TAB BAR ----------------------
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.orange, width: 2.w),
            ),
            child: Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTab("All", 0),
                  _buildTab("Unread", 1),
                  _buildTab("Read", 2),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),

          /// ---------------------- SELECTED SCREEN ----------------------
          Expanded(
            child: Obx(() => screens[selectedIndex.value]),
          ),
        ],
      ),
    );
  }

  /// ---------------------- TAB ITEM WIDGET ----------------------
  Widget _buildTab(String title, int index) {
    bool isActive = selectedIndex.value == index;

    return GestureDetector(
      onTap: () => selectedIndex.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
