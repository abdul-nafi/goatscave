import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const ShopCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                width: 64.w,
                height: 64.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              name,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalShopRow extends StatelessWidget {
  final List<ShopCard> shops;
  final String allLabel;
  final VoidCallback? onAllTap;

  const HorizontalShopRow({
    super.key,
    required this.shops,
    required this.allLabel,
    this.onAllTap,
  });

  @override
  Widget build(BuildContext context) {
    // Show only first 5, 6th is "All Shops/Restaurants"
    final visibleShops = shops.length > 5 ? shops.sublist(0, 5) : shops;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          ...visibleShops,
          GestureDetector(
            onTap: onAllTap,
            child: Container(
              width: 80.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  allLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
