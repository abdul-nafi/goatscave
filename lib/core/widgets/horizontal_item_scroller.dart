import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotizontalItemScroller extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback? onSeeAll;

  const HotizontalItemScroller({
    super.key,
    required this.title,
    required this.children,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              if (onSeeAll != null)
                GestureDetector(
                  onTap: onSeeAll,
                ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 120.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: children.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (ctx, index) => children[index],
          ),
        ),
      ],
    );
  }
}
