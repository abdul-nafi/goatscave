import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/core/core.dart';
import 'package:goatscave/features/food/food.dart';
import 'package:goatscave/features/cart/cart.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load restaurant details and menu when screen initializes
    context.read<FoodBloc>().add(LoadRestaurantDetail(widget.restaurantId));
    context.read<FoodBloc>().add(LoadRestaurantMenu(widget.restaurantId));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FoodBloc, FoodState>(
          listener: (context, state) {
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, foodState) {
            final restaurant = foodState.selectedRestaurant;

            if (restaurant == null ||
                foodState.status == FoodStatus.restaurantDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                // App Bar with Restaurant Image
                SliverAppBar(
                  expandedHeight: 200.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          restaurant.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withAlpha(179),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  backgroundColor: AppColors.surface,
                  leading: IconButton(
                    icon: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withAlpha(204),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back,
                          color: AppColors.textPrimary, size: 18.sp),
                    ),
                    onPressed: () => context.go('/food'),
                  ),
                  actions: [
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withAlpha(204),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.share,
                            color: AppColors.textPrimary, size: 18.sp),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                // Restaurant Info
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.surface,
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          restaurant.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            // Rating
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: AppColors.warning, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  restaurant.rating.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16.w),
                            // Delivery Time
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: AppColors.primary, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  restaurant.deliveryTime,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                            SizedBox(width: 16.w),
                            // Delivery Fee
                            Row(
                              children: [
                                Icon(Icons.delivery_dining,
                                    color: AppColors.success, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  '₹${restaurant.deliveryFee.toInt()}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (restaurant.address != null) ...[
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: AppColors.textTertiary, size: 16.sp),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  restaurant.address!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.textTertiary,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 8.h),
                        // Categories
                        Wrap(
                          spacing: 8.w,
                          children:
                              restaurant.categories.take(3).map((category) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                category,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Menu Search Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16.w),
                          Icon(Icons.search,
                              color: AppColors.textTertiary, size: 20.sp),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search in menu...',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.textTertiary,
                                    ),
                                border: InputBorder.none,
                              ),
                              onChanged: (query) {
                                context
                                    .read<FoodBloc>()
                                    .add(SearchMenuItems(query));
                              },
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            IconButton(
                              icon: Icon(Icons.clear,
                                  color: AppColors.textTertiary, size: 18.sp),
                              onPressed: () {
                                _searchController.clear();
                                context
                                    .read<FoodBloc>()
                                    .add(const SearchMenuItems(''));
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Menu Category Filter
                SliverToBoxAdapter(
                  child: _buildMenuCategoryFilter(foodState),
                ),

                // Food Items List
                if (foodState.hasMenuItems)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final foodItem = foodState.filteredMenu[index];
                        return _buildFoodItemCard(context, foodItem);
                      },
                      childCount: foodState.filteredMenu.length,
                    ),
                  )
                else if (!foodState.isLoading)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fastfood,
                                size: 64.sp, color: AppColors.textTertiary),
                            SizedBox(height: 16.h),
                            Text(
                              'No items found',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Try changing your search or filters',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        // Floating Cart Button - UPDATED: Now navigates to cart screen
        floatingActionButton: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            if (cartState.cart.items.isEmpty) return const SizedBox.shrink();

            return FloatingActionButton.extended(
              onPressed: () => context.go('/cart'),
              icon: Badge(
                label: Text(cartState.cart.totalItems.toString()),
                child: const Icon(Icons.shopping_cart),
              ),
              label: Text('₹${cartState.cart.totalAmount.toStringAsFixed(0)}'),
              backgroundColor: AppColors.foodColor,
              foregroundColor: AppColors.textInverse,
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuCategoryFilter(FoodState state) {
    final categoryNames = state.restaurantMenu
        .map((item) => item.category)
        .toSet() // Remove duplicates
        .toList();
    final categories = [
      'All',
      ...categoryNames.where((category) => category != 'All')
    ];

    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = state.selectedMenuCategory == category ||
              (category == 'All' && state.selectedMenuCategory == null);

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  if (category == 'All') {
                    context.read<FoodBloc>().add(const ClearMenuFilter());
                  } else {
                    context
                        .read<FoodBloc>()
                        .add(FilterMenuByCategory(category));
                  }
                } else {
                  context.read<FoodBloc>().add(const ClearMenuFilter());
                }
              },
              backgroundColor: AppColors.background,
              selectedColor: AppColors.foodColor,
              labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? AppColors.textInverse
                        : AppColors.textPrimary,
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodItemCard(BuildContext context, FoodItem item) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        // Find the item in cart to get current quantity
        final cartItem = cartState.cart.items.firstWhere(
          (cartItem) => cartItem.id == item.id,
          orElse: () => const CartItem(
            id: '',
            name: '',
            description: '',
            price: 0,
            quantity: 0,
            type: ProductType.food,
          ),
        );
        final quantity = cartItem.quantity;

        return Container(
          margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Image
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: item.hasDiscount
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'OFFER',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.textInverse,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 16.w),

              // Food Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),

                    // Tags
                    Row(
                      children: [
                        if (item.isVegetarian)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.success.withAlpha(26),
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: AppColors.success),
                            ),
                            child: Text(
                              '🟢 Veg',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.success,
                                  ),
                            ),
                          ),
                        if (item.isSpicy) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.error.withAlpha(26),
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: AppColors.error),
                            ),
                            child: Text(
                              '🌶️ Spicy',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.error,
                                  ),
                            ),
                          ),
                        ],
                        if (item.rating != null) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withAlpha(26),
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: AppColors.warning),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star,
                                    size: 12.sp, color: AppColors.warning),
                                SizedBox(width: 2.w),
                                Text(
                                  item.rating.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColors.warning,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Price and Add Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.hasDiscount)
                              Text(
                                '₹${item.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.textTertiary,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            Text(
                              '₹${item.finalPrice}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.foodColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            if (item.preparationTime > 0)
                              Text(
                                '${item.preparationTime} min',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.textTertiary,
                                    ),
                              ),
                          ],
                        ),

                        // Quantity Controls
                        quantity > 0
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColors.foodColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => _updateCartQuantity(
                                          item, quantity - 1),
                                      icon: Icon(Icons.remove,
                                          color: AppColors.textInverse,
                                          size: 18.sp),
                                      padding: EdgeInsets.zero,
                                      constraints:
                                          BoxConstraints(minWidth: 32.w),
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: AppColors.textInverse,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    IconButton(
                                      onPressed: () => _updateCartQuantity(
                                          item, quantity + 1),
                                      icon: Icon(Icons.add,
                                          color: AppColors.textInverse,
                                          size: 18.sp),
                                      padding: EdgeInsets.zero,
                                      constraints:
                                          BoxConstraints(minWidth: 32.w),
                                    ),
                                  ],
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () => _addToCart(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.foodColor,
                                  foregroundColor: AppColors.textInverse,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                ),
                                child: Text(
                                  'ADD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addToCart(FoodItem item) {
    final cartItem = CartItem.fromFoodItem(
      item.id,
      item.name,
      item.description,
      item.price,
      quantity: 1,
      imageUrl: item.imageUrl,
      restaurantId: widget.restaurantId,
      discountPrice: item.discountPrice,
      category: item.category,
      isVegetarian: item.isVegetarian,
      isSpicy: item.isSpicy,
      preparationTime: item.preparationTime,
    );
    context.read<CartBloc>().add(CartItemAdded(cartItem));

    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _updateCartQuantity(FoodItem item, int newQuantity) {
    if (newQuantity <= 0) {
      context.read<CartBloc>().add(CartItemRemoved(item.id));
    } else {
      // For quantity updates, we use CartItemQuantityUpdated event
      context
          .read<CartBloc>()
          .add(CartItemQuantityUpdated(item.id, newQuantity));
    }
  }
}
