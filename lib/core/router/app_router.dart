import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/features/food/food.dart';
import 'package:goatscave/features/food/presentation/screens/food_home_screen.dart';
import 'package:goatscave/features/grocery/grocery.dart';

import 'package:goatscave/features/home/home.dart';

import 'package:goatscave/features/taxi/taxi.dart';
import 'package:goatscave/features/cart/cart.dart';
import 'package:goatscave/core/core.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => Placeholder(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => Placeholder(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) =>
            const HomeScreen(), // Updated to use GroceryHomePage as HomeScreen
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: "/grocery",
        name: 'grocery',
        builder: (context, state) => const GroceryHomeScreen(),
      ),
      // 🆕 NEW ROUTES FOR SUPER APP

      GoRoute(
        path: "/bus",
        builder: (context, state) =>
            const PlaceholderScreen(title: 'Bus Tracking'),
      ),
      GoRoute(
        path: "/parcels",
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: "/food",
        builder: (context, state) {
          return const FoodHomeScreen();
        },
      ),
      GoRoute(
        path: '/restaurant/:id',
        name: 'restaurant',
        builder: (context, state) {
          final restaurantId = state.pathParameters['id']!;
          return RestaurantDetailScreen(restaurantId: restaurantId);
        },
      ),
      GoRoute(
        path: "/wallet",
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: "/help",
        builder: (context, state) =>
            const PlaceholderScreen(title: 'Help & Support'),
      ),
      GoRoute(
          path: "/profile", builder: (context, state) => const Placeholder()),
      GoRoute(
        path: "/taxi",
        builder: (context, state) => const TaxiBookingScreen(),
      ),
      GoRoute(
        path: "/cart",
        builder: (context, state) => const CartScreen(),
      ),
    ],
  );
}

// 🆕 Add this placeholder class for screens we'll build later
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              '$title\nComing Soon!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
