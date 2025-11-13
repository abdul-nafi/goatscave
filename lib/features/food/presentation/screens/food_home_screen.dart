import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/core/core.dart';
import 'package:goatscave/features/food/food.dart';

class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({super.key});

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load all restaurants when screen initializes
    context.read<FoodBloc>().add(const LoadAllRestaurants());
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
        leading: IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Food Delivery',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state.status == FoodStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              // Search Bar
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
                              hintText: 'Search for restaurants or food...',
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
                                  .add(SearchFoodAndRestaurants(query));
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
                                  .add(const SearchFoodAndRestaurants(''));
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Show search results or normal view
              if (_searchController.text.isNotEmpty)
                _buildSearchResults(state)
              else
                _buildNormalView(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(FoodState state) {
    if (state.isSearching) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final hasResults = state.searchResults.isNotEmpty;

    if (!hasResults && state.searchQuery.isNotEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off,
                    size: 64.sp, color: AppColors.textTertiary),
                SizedBox(height: 16.h),
                Text(
                  'No results found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Try different keywords',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final result = state.searchResults[index];
          return _buildSearchResultCard(
              context, result); // Use the correct method
        },
        childCount: hasResults ? state.searchResults.length : 0,
      ),
    );
  }

// ADD THIS NEW METHOD FOR SEARCH RESULT CARDS
  Widget _buildSearchResultCard(BuildContext context, SearchResult result) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      child: ListTile(
        leading: Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: NetworkImage(result.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: result.type == SearchResultType.foodItem
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.foodColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.r),
                        topLeft: Radius.circular(8.r),
                      ),
                    ),
                    child: Icon(
                      Icons.fastfood,
                      size: 12.sp,
                      color: AppColors.textInverse,
                    ),
                  ),
                )
              : null,
        ),
        title: Text(
          result.displayName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.displayDescription,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            if (result.type == SearchResultType.foodItem)
              Text(
                '₹${result.foodItem!.finalPrice}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.foodColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
          ],
        ),
        trailing: Icon(
          result.type == SearchResultType.restaurant
              ? Icons.restaurant
              : Icons.arrow_forward_ios,
          size: 16.sp,
        ),
        onTap: () {
          if (result.type == SearchResultType.restaurant) {
            context.go('/restaurant/${result.restaurant.id}');
          } else {
            // Navigate to restaurant with the food item
            context.go('/restaurant/${result.restaurant.id}');
          }
        },
      ),
    );
  }

  Widget _buildNormalView(FoodState state) {
    return SliverList(
      delegate: SliverChildListDelegate([
        // Featured Restaurants Section
        _buildSectionHeader('Featured Restaurants', context),
        _buildRestaurantHorizontalList(state.restaurants, context),

        // Popular Categories Section
        _buildSectionHeader('Popular Categories', context),
        _buildCategoryGrid(context),

        // All Restaurants Section
        _buildSectionHeader('All Restaurants', context),
        _buildAllRestaurantsList(state.restaurants, context),
      ]),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget _buildRestaurantHorizontalList(
      List<Restaurant> restaurants, BuildContext context) {
    return SizedBox(
      height: 220.h, // Increased height to accommodate content
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return GestureDetector(
            onTap: () {
              context.go('/restaurant/${restaurant.id}');
            },
            child: Container(
              width: 180.w, // Slightly wider to accommodate content
              margin: EdgeInsets.only(right: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Add this to prevent overflow
                children: [
                  // Restaurant Image
                  Container(
                    width: 180.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: NetworkImage(restaurant.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Restaurant Info - Use Expanded for text sections
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          restaurant.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Flexible(
                          // Use Flexible instead of Expanded for description
                          child: Text(
                            restaurant.description,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: AppColors.warning, size: 14.sp),
                            SizedBox(width: 4.w),
                            Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.access_time,
                                color: AppColors.primary, size: 14.sp),
                            SizedBox(width: 4.w),
                            Text(
                              restaurant.deliveryTime,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    final categories = [
      {
        'name': 'Indian',
        'icon': Icons.restaurant,
        'color': AppColors.foodColor
      },
      {'name': 'Chinese', 'icon': Icons.ramen_dining, 'color': Colors.orange},
      {'name': 'Italian', 'icon': Icons.dinner_dining, 'color': Colors.green},
      {'name': 'Biryani', 'icon': Icons.rice_bowl, 'color': Colors.red},
      {'name': 'Vegetarian', 'icon': Icons.eco, 'color': Colors.green},
      {'name': 'Desserts', 'icon': Icons.cake, 'color': Colors.pink},
    ];

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category['icon'] as IconData,
                  color: category['color'] as Color, size: 24.sp),
              SizedBox(height: 8.h),
              Text(
                category['name'] as String,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAllRestaurantsList(
      List<Restaurant> restaurants, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: restaurants.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return _buildRestaurantCard(context, restaurant);
      },
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        leading: Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: NetworkImage(restaurant.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          restaurant.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.star, color: AppColors.warning, size: 14.sp),
                SizedBox(width: 4.w),
                Text(restaurant.rating.toString()),
                SizedBox(width: 8.w),
                Icon(Icons.access_time, color: AppColors.primary, size: 14.sp),
                SizedBox(width: 4.w),
                Text(restaurant.deliveryTime),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
        onTap: () {
          context.go('/restaurant/${restaurant.id}');
        },
      ),
    );
  }
}
