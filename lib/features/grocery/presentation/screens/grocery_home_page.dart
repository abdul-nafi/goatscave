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
      body: Column(children: [
        const GrocerySearchBar(),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
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
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Row(
                    children: [
                      CategoryIconButton(
                        label: 'Fruits',
                        imageUrl:
                            'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=facearea&w=48&h=48',
                      ),
                      CategoryIconButton(
                        label: 'Vegetables',
                        imageUrl:
                            'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=facearea&w=48&h=48',
                      ),
                      CategoryIconButton(
                        label: 'Bakery',
                        imageUrl:
                            'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=facearea&w=48&h=48',
                      ),
                      CategoryIconButton(
                        label: 'Dairy',
                        imageUrl:
                            'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=facearea&w=48&h=48',
                      ),
                      // Add more as needed
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Text(
                        'Featured Items',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 0.7,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  children: const [
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=facearea&w=128&h=128',
                      name: 'Fresh Apples',
                      price: '\$2.99',
                      unit: '/kg',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1465101178521-c1a9136a3c5a?auto=format&fit=facearea&w=128&h=128',
                      name: 'Bananas',
                      price: '\$1.49',
                      unit: '/kg',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=facearea&w=128&h=128',
                      name: 'Bread',
                      price: '\$3.50',
                      unit: '/loaf',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1465101178521-c1a9136a3c5a?auto=format&fit=facearea&w=128&h=128',
                      name: 'Tomatoes',
                      price: '\$2.20',
                      unit: '/kg',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=facearea&w=128&h=128',
                      name: 'Oranges',
                      price: '\$2.80',
                      unit: '/kg',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=facearea&w=128&h=128',
                      name: 'Carrots',
                      price: '\$1.99',
                      unit: '/kg',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=facearea&w=128&h=128',
                      name: 'Milk',
                      price: '\$0.99',
                      unit: '/L',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1465101178521-c1a9136a3c5a?auto=format&fit=facearea&w=128&h=128',
                      name: 'Potatoes',
                      price: '\$1.20',
                      unit: '/kg',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=facearea&w=128&h=128',
                      name: 'Grapes',
                      price: '\$3.99',
                      unit: '/kg',
                    ),
                    ProductCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=facearea&w=128&h=128',
                      name: 'Cucumbers',
                      price: '\$2.10',
                      unit: '/kg',
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Text(
                        'Shops',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                HorizontalShopRow(
                  shops: const [
                    ShopCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=facearea&w=64&h=64',
                      name: 'Fresh Mart',
                    ),
                    ShopCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=facearea&w=64&h=64',
                      name: 'Veggie Hub',
                    ),
                    ShopCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=facearea&w=64&h=64',
                      name: 'Fruit World',
                    ),
                    ShopCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=facearea&w=64&h=64',
                      name: 'Daily Dairy',
                    ),
                    ShopCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1465101178521-c1a9136a3c5a?auto=format&fit=facearea&w=64&h=64',
                      name: 'Bakery Bliss',
                    ),
                    // Add more shops if needed
                  ],
                  allLabel: 'All Shops',
                  onAllTap: () {
                    // Navigate to all shops page
                  },
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
