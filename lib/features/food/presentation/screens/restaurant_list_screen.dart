import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/core/core.dart';
import 'package:goatscave/features/food/food.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load restaurants and categories when screen initializes
    context.read<FoodBloc>().add(const LoadRestaurants());
    context.read<FoodBloc>().add(LoadFoodCategories());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurants',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/home'),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: BlocConsumer<FoodBloc, FoodState>(
        listener: (context, state) {
          // Handle any side effects like showing error messages
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              // Search Bar
              _buildSearchBar(context),

              // Categories
              _buildCategoryList(state),

              // Restaurant List
              _buildRestaurantList(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
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
            Icon(Icons.search, color: AppColors.textTertiary, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search restaurants or food...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  context.read<FoodBloc>().add(SearchRestaurants(query));
                },
              ),
            ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: Icon(Icons.clear,
                    color: AppColors.textTertiary, size: 18.sp),
                onPressed: () {
                  _searchController.clear();
                  context.read<FoodBloc>().add(const SearchRestaurants(''));
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(FoodState state) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          final category = state.categories[index];
          final isSelected = state.selectedCategory == category.name;

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text('${category.name} (${category.itemCount})'),
              selected: isSelected,
              onSelected: (selected) {
                if (category.name == 'All') {
                  context.read<FoodBloc>().add(const LoadRestaurants());
                } else {
                  context.read<FoodBloc>().add(FilterByCategory(category.name));
                }
              },
              backgroundColor: AppColors.background,
              selectedColor: AppColors.foodColor,
              labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? AppColors.textInverse
                        : AppColors.textPrimary,
                  ),
              avatar: isSelected ? Text(category.icon) : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRestaurantList(FoodState state) {
    if (state.isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(color: AppColors.foodColor),
        ),
      );
    }

    if (!state.hasRestaurants) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant,
                  size: 64.sp, color: AppColors.textTertiary),
              SizedBox(height: 16.h),
              Text(
                'No restaurants found',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              Text(
                'Try changing your search or filters',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<FoodBloc>().add(const LoadRestaurants());
        },
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: state.filteredRestaurants.length,
          itemBuilder: (context, index) {
            final restaurant = state.filteredRestaurants[index];
            return _buildRestaurantCard(context, restaurant);
          },
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        context.read<FoodBloc>().add(LoadRestaurantDetail(restaurant.id));
        context.go('/food/restaurant/${restaurant.id}');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            Stack(
              children: [
                Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Status Badge
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: restaurant.isOpen
                          ? AppColors.success.withAlpha(230)
                          : AppColors.error.withAlpha(230),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      restaurant.isOpen ? 'OPEN' : 'CLOSED',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textInverse,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      restaurant.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: restaurant.isFavorite
                          ? AppColors.error
                          : AppColors.textPrimary,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),

            // Restaurant Info
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Rating
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
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
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8.h),

                  // Delivery Info
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 16.sp, color: AppColors.primary),
                      SizedBox(width: 4.w),
                      Text(
                        restaurant.deliveryTime,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(width: 16.w),
                      Icon(Icons.delivery_dining,
                          size: 16.sp, color: AppColors.success),
                      SizedBox(width: 4.w),
                      Text(
                        '₹${restaurant.deliveryFee.toInt()}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      if (restaurant.minOrder != null) ...[
                        SizedBox(width: 16.w),
                        Icon(Icons.shopping_bag,
                            size: 16.sp, color: AppColors.textTertiary),
                        SizedBox(width: 4.w),
                        Text(
                          'Min. ₹${restaurant.minOrder!.toInt()}',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Categories
                  Wrap(
                    spacing: 8.w,
                    children: restaurant.categories.take(3).map((category) {
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
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
