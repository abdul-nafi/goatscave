import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/auth.dart';
import '../../features/grocery/grocery.dart';
import '../../features/services/services.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) =>
            const HomeScreen(), // Updated to new HomeScreen
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: "/grocery",
        builder: (context, state) => const GroceryHomePage(),
      ),
      // 🆕 NEW ROUTES FOR SUPER APP
      GoRoute(
        path: "/taxi",
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: "/bus",
        builder: (context, state) =>
            const PlaceholderScreen(title: 'Bus Tracking'),
      ),
      GoRoute(
        path: "/food",
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: "/parcels",
        builder: (context, state) => const Placeholder(),
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
            Icon(Icons.construction, size: 64, color: AppColors.primary),
            SizedBox(height: 16),
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
