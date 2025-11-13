import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/core/core.dart';
import 'package:goatscave/features/cart/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/food'),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.hasItems) {
                return IconButton(
                  icon:
                      const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () {
                    context.read<CartBloc>().add(CartCleared());
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cart.items.isEmpty) {
            return _buildEmptyCart(context);
          }

          return Column(
            children: [
              Expanded(
                child: _buildCartItems(context, state),
              ),
              _buildCheckoutSection(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80.sp,
            color: AppColors.textTertiary,
          ),
          SizedBox(height: 24.h),
          Text(
            'Your cart is empty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12.h),
          Text(
            'Add some delicious items to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          ElevatedButton(
            onPressed: () => context.go('/food'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.foodColor,
              foregroundColor: AppColors.textInverse,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            ),
            child: Text(
              'Browse Food',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, CartState state) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: state.cart.items.length,
      itemBuilder: (context, index) {
        final item = state.cart.items[index];
        return _buildCartItem(context, item);
      },
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Item Image
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl ??
                    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=100'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    if (item.discountPrice != null) ...[
                      Text(
                        '₹${item.price}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      '₹${item.finalPrice}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.foodColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quantity Controls
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (item.quantity > 1) {
                      context.read<CartBloc>().add(
                            CartItemQuantityUpdated(item.id, item.quantity - 1),
                          );
                    } else {
                      context.read<CartBloc>().add(CartItemRemoved(item.id));
                    }
                  },
                  icon: Icon(Icons.remove,
                      size: 18.sp, color: AppColors.textPrimary),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.w, maxWidth: 32.w),
                ),
                Text(
                  item.quantity.toString(),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                          CartItemQuantityUpdated(item.id, item.quantity + 1),
                        );
                  },
                  icon: Icon(Icons.add,
                      size: 18.sp, color: AppColors.textPrimary),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 32.w, maxWidth: 32.w),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartState state) {
    const deliveryFee = 40.0;
    final tax = state.cart.totalAmount * 0.05;
    final total = state.cart.totalAmount + deliveryFee + tax;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          // Price Breakdown
          _buildPriceRow(
            context,
            label: 'Subtotal',
            value: '₹${state.cart.totalAmount.toStringAsFixed(0)}',
          ),
          SizedBox(height: 8.h),
          _buildPriceRow(
            context,
            label: 'Delivery Fee',
            value: '₹${deliveryFee.toStringAsFixed(0)}',
          ),
          SizedBox(height: 8.h),
          _buildPriceRow(
            context,
            label: 'Taxes (5%)',
            value: '₹${tax.toStringAsFixed(0)}',
          ),
          Divider(height: 24.h),
          _buildPriceRow(
            context,
            label: 'Total',
            value: '₹${total.toStringAsFixed(0)}',
            isTotal: true,
          ),
          SizedBox(height: 16.h),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _proceedToCheckout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.foodColor,
                foregroundColor: AppColors.textInverse,
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: Text(
                'Proceed to Checkout - ₹${total.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
        ),
        Text(
          value,
          style: isTotal
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.foodColor,
                  )
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  void _proceedToCheckout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout Coming Soon'),
        content: const Text(
            'Checkout and payment integration will be available in the next update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Shopping'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Simulate successful order
              context.read<CartBloc>().add(CartCleared());
              _showOrderSuccess(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.foodColor,
              foregroundColor: AppColors.textInverse,
            ),
            child: const Text('Place Demo Order'),
          ),
        ],
      ),
    );
  }

  void _showOrderSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed!',
            style: TextStyle(color: AppColors.success)),
        content: const Text(
            'Your demo order has been placed successfully. In the real app, this would process payment and start delivery.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/food');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
