import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to GoatsCave",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.h),
            AppTextField(
              hintText: "Email",
              controller: emailController,
            ),
            SizedBox(height: 20.h),
            AppTextField(
              hintText: "Password",
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(height: 30.h),
            PrimaryButton(
              text: "Login",
              onPressed: () {
                // handle login logic
              },
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () {
                context.go('/signup');
              },
              child: Text(
                "Don't have an account? Sign up",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
