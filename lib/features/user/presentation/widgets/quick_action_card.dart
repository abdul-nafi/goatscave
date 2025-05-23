import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.grey.shade200,
        ),
        child: Column(
          children: [
            Icon(icon, size: 32.sp, color: Colors.black87),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
