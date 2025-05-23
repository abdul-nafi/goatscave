import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/core.dart';

class UserTopAppBar extends StatelessWidget {
  const UserTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Greeting
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Abdul 👋",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 4.h),
            Text(
              "Welcome to GoatsCave",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        /// Notification + Profile Picture
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded,
                  color: AppColors.textPrimary),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 20.r,
              backgroundImage:
                  const AssetImage("lib/assets/images/woman-7426320_640.png"),
            ),
          ],
        ),
      ],
    );
  }
}
