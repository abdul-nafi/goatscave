import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(36),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32.sp, color: AppColors.textPrimary),
            SizedBox(height: 8.h),
            Text(
              label,
              style: textStyle?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
