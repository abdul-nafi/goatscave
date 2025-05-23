import 'package:go_router/go_router.dart';

import '../../features/auth/auth.dart';
import '../../features/services/services.dart';
import '../../features/user/user.dart';

class AppRouter {
  static final router = GoRouter(initialLocation: "/home", routes: [
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
      builder: (context, state) => const UserHomePage(),
    ),
    GoRoute(
        path: '/services',
        builder: (context, state) => const AllServicesPage()),
  ]);
}
