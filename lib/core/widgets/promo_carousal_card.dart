import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCarouselBanner extends StatefulWidget {
  final List<String> imagePaths;
  const PromoCarouselBanner({super.key, required this.imagePaths});

  @override
  State<PromoCarouselBanner> createState() => _PromoCarouselBannerState();
}

class _PromoCarouselBannerState extends State<PromoCarouselBanner> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.imagePaths.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (_, index) => ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(widget.imagePaths[index], fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imagePaths.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _currentPage == index ? Colors.black : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
