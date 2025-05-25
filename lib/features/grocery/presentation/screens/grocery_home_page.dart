import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/core/core.dart';

import '../../grocery.dart';

class GroceryHomePage extends StatelessWidget {
  const GroceryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          'Grocery',
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const GrocerySearchBar(),
          SizedBox(height: 8.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Row(
              children: [
                CategoryChipButton(label: 'Fruits'),
                CategoryChipButton(label: 'Vegetables'),
                CategoryChipButton(label: 'Dairy'),
                CategoryChipButton(label: 'Bakery'),
                CategoryChipButton(label: 'Farm'),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Row(
              children: [
                HorizontalImageCard(
                  imageUrl:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuAV3H98qfOtKhjKvFfJyTaqD5bOQe3OJ0JcIWT30jpe8sZQ5WwuPPEqmQJYV-KmZIbsO3bKByLM9Nfgru-OSNEFMk84eTqRSvvkyQsS6w_zOl7J_sBD5DfXxAmEd92KKUa44c583arWdZe3VIYfc7ZvfTGdEzF-rPjUjh4mXKeg0J4slJqHFlN94xw2fbTWQAOW3J-5lFFNf8dav2hUf96EaxM_01GUGjeE002sxS5sJgGpttDxN65RPhlk0M4lEPR8QjFeXqTPDE6s",
                  label: "Fresh Produce",
                ),
                HorizontalImageCard(
                  imageUrl:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuD0YbDo8VJtsbuBQ5BkVRBnbKhyFmwrqbqOC7NiHJWrQ2XMoo83JlxfNMJyic0mWmWuWOX2iSI37CxTArPgqy9LrPw15TJTe51w67TaBg6vLH9-X3iZ7OCYIo1OvJUJ5G1Lh6Yqd3jUv4TZ1WOdJJmOEnhfh_zO2SnOQpTJRSnXD4ckRqVKKGGgK_P9SQWr3rBdSqhxsm6EM9I1gNE3PhdLIbaYW5PgyOaqOgFxx-e-7mfGJjyjqInhSqe7Mf9VeHLJ5HVfdOcS50Fc",
                  label: "Quality Meats",
                ),
                HorizontalImageCard(
                  imageUrl:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuDYtuNpjCbpdOHv293RAyRJjJCIEERRbcjRhFEa8ZPYUjVnJcYWwBbXqaWQZGUbdRY6xsv0Rqk6cm4KzvlETuKxME9bchv3vcYLaOlFeYmJyLnPc2MJlgyj2nKwCHkzQoehqmHKUd7niskMgNcY6Ld5RM7mZ4J3mAilCwtru_QBVcL6NzVY118-YBdXt3msClCMH2pwFKcyIiTldoYQlg_47ib7Mcy6LutQMZm9KiDcnl1F18TnQ5S9-iSSA0jU2OcTtmq0b99h2tEY",
                  label: "Organic Choices",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
