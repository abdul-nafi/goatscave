import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goatscave/core/core.dart';
import 'package:goatscave/core/theme/colors.dart';

class CategoryChipButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool selected;

  const CategoryChipButton({
    super.key,
    required this.label,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color:
              selected ? AppColors.primary : AppColors.secondary.withAlpha(32),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
