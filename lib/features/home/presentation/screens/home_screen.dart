import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/core/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header section - fixed height
            _buildHeader(context),
            SizedBox(height: 16.h),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Actions Grid
                    _buildQuickActions(),
                    SizedBox(height: 24.h),

                    // Live Bus Tracking Section
                    _buildBusTrackingSection(context),
                    SizedBox(height: 24.h),

                    // Food & Grocery Promo
                    _buildPromoSection(context),
                    SizedBox(height: 24.h), // Extra space at bottom
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Welcome to GoatsCave',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/profile'),
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(77),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                color: AppColors.textInverse,
                size: 20.sp, // Reduced size
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final quickActions = [
      {
        'icon': Icons.local_taxi,
        'label': 'Taxi/Auto',
        'color': AppColors.taxiColor,
        'route': '/taxi',
      },
      {
        'icon': Icons.directions_bus,
        'label': 'Bus Track',
        'color': AppColors.busColor,
        'route': '/bus',
      },
      {
        'icon': Icons.restaurant,
        'label': 'Food',
        'color': AppColors.foodColor,
        'route': '/food',
      },
      {
        'icon': Icons.shopping_basket,
        'label': 'Grocery',
        'color': AppColors.groceryColor,
        'route': '/grocery',
      },
      {
        'icon': Icons.local_shipping,
        'label': 'Parcels',
        'color': AppColors.parcelsColor,
        'route': '/parcels',
      },
      {
        'icon': Icons.plumbing,
        'label': 'Services',
        'color': AppColors.servicesColor,
        'route': '/services',
      },
      {
        'icon': Icons.account_balance_wallet,
        'label': 'Wallet',
        'color': AppColors.primary,
        'route': '/wallet',
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help',
        'color': AppColors.textTertiary,
        'route': '/help',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.85,
      ),
      itemCount: quickActions.length,
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return GestureDetector(
          onTap: () => context.go(action['route'] as String),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r), // Slightly smaller
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4.r, // Reduced blur
                  offset: Offset(0, 1.h), // Smaller offset
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.w, // Smaller container
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: action['color'] as Color,
                    borderRadius: BorderRadius.circular(10.r), // Smaller radius
                  ),
                  child: Icon(
                    action['icon'] as IconData,
                    color: AppColors.textInverse,
                    size: 18.sp, // Smaller icon
                  ),
                ),
                SizedBox(height: 6.h), // Reduced spacing
                Text(
                  action['label'] as String,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10.sp, // Smaller font
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBusTrackingSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w), // Reduced padding
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r), // Smaller radius
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r, // Reduced blur
            offset: Offset(0, 2.h), // Smaller offset
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w, // Smaller container
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.busColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(10.r), // Smaller radius
                ),
                child: Icon(
                  Icons.directions_bus,
                  color: AppColors.busColor,
                  size: 18.sp, // Smaller icon
                ),
              ),
              SizedBox(width: 10.w), // Reduced spacing
              Expanded(
                child: Text(
                  'Live Bus Tracking',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp, // Slightly smaller
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h), // Reduced spacing
          Container(
            height: 100.h, // Reduced height
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12.r), // Smaller radius
              border: Border.all(color: AppColors.border),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 28.sp, // Smaller icon
                    color: AppColors.textTertiary,
                  ),
                  SizedBox(height: 6.h), // Reduced spacing
                  Text(
                    'Track buses in real-time',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 12.sp, // Smaller font
                        ),
                  ),
                  SizedBox(height: 8.h), // Reduced spacing
                  ElevatedButton(
                    onPressed: () => context.go('/bus'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.busColor,
                      foregroundColor: AppColors.textInverse,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w, // Reduced padding
                        vertical: 6.h,
                      ),
                      minimumSize: Size.zero, // Remove minimum size constraints
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'View Bus Map',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 12.sp, // Smaller font
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Food & Grocery',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
              ),
        ),
        SizedBox(height: 8.h), // Reduced spacing
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => context.go('/food'),
                child: Container(
                  height: 75.h, // Even smaller height
                  padding: EdgeInsets.all(8.w), // Minimal padding
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.foodColor.withOpacity(0.9),
                        AppColors.foodColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r), // Smaller radius
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.foodColor.withOpacity(0.3),
                        blurRadius: 4.r, // Smaller shadow
                        offset: Offset(0, 1.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: AppColors.textInverse,
                        size: 16.sp, // Smallest icon
                      ),
                      SizedBox(height: 4.h), // Minimal spacing
                      Text(
                        'Food',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.textInverse,
                              fontSize: 11.sp, // Smaller font
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                      ),
                      Text(
                        'Delivery',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textInverse.withOpacity(0.8),
                              fontSize: 8.sp, // Smallest font
                            ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w), // Minimal spacing
            Expanded(
              child: GestureDetector(
                onTap: () => context.go('/grocery'),
                child: Container(
                  height: 75.h, // Even smaller height
                  padding: EdgeInsets.all(8.w), // Minimal padding
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.groceryColor.withOpacity(0.9),
                        AppColors.groceryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r), // Smaller radius
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.groceryColor.withOpacity(0.3),
                        blurRadius: 4.r, // Smaller shadow
                        offset: Offset(0, 1.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket,
                        color: AppColors.textInverse,
                        size: 16.sp, // Smallest icon
                      ),
                      SizedBox(height: 4.h), // Minimal spacing
                      Text(
                        'Grocery',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.textInverse,
                              fontSize: 11.sp, // Smaller font
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                      ),
                      Text(
                        'Delivery',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textInverse.withOpacity(0.8),
                              fontSize: 8.sp, // Smallest font
                            ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r, // Reduced blur
            offset: Offset(0, -2.h), // Smaller offset
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        selectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10.sp, // Smaller font
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10.sp, // Smaller font
            ),
        iconSize: 20.sp, // Smaller icons
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/taxi');
              break;
            case 2:
              context.go('/grocery');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_taxi_outlined),
            activeIcon: Icon(Icons.local_taxi),
            label: 'Taxi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            activeIcon: Icon(Icons.shopping_basket),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
