import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goatscave/core/core.dart';
import 'package:goatscave/features/user/presentation/widgets/animated_button_list.dart';

import '../../user.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserTopAppBar(),
                SizedBox(height: 12.h),
                // Search bar placeholder
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search services...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.inputFill,
                  ),
                ),
                SizedBox(height: 24.h),

                const PromoCarouselBanner(
                  imagePaths: [
                    'lib/assets/images/banner1.jpg',
                    'lib/assets/images/banner2.jpg',
                  ],
                ),
                SizedBox(height: 24.h),

                /// Quick Actions Title
                Text(
                  "Quick Actions",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: getHomePageButtons(context),
                ),
                SizedBox(
                  height: 24.h,
                ),
                const HotizontalItemScroller(title: 'Services', children: [
                  ServiceCard(icon: Icons.plumbing, label: "Plumber"),
                  ServiceCard(icon: Icons.chair, label: "Rental"),
                  ServiceCard(icon: Icons.cleaning_services, label: "Cleaning"),
                  ServiceCard(icon: Icons.electric_bolt, label: "Electrician"),
                  ServiceCard(icon: Icons.local_car_wash, label: "Car Wash"),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
