import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goatscave/core/core.dart';

class AnimatedActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const AnimatedActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  State<AnimatedActionButton> createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<AnimatedActionButton> {
  double _scale = 1.0;

  void _animateDown(TapDownDetails details) {
    setState(() => _scale = 0.95);
  }

  void _animateUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _animateCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _animateDown,
      onTapUp: _animateUp,
      onTapCancel: _animateCancel,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: _scale),
        duration: const Duration(milliseconds: 100),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.primary.withAlpha(36)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: 32.sp, color: AppColors.textPrimary),
                  SizedBox(height: 8.h),
                  Text(
                    widget.label,
                    style: textStyle?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
