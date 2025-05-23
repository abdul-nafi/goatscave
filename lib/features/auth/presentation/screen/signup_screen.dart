import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Your Account",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.h),

            // Full Name
            AppTextField(
              hintText: "Full Name",
              controller: nameController,
            ),
            SizedBox(height: 20.h),

            // Email
            AppTextField(
              hintText: "Email",
              controller: emailController,
            ),
            SizedBox(height: 20.h),

            // Password
            AppTextField(
              hintText: "Password",
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20.h),

            // Confirm Password
            AppTextField(
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 30.h),

            // Sign Up Button
            PrimaryButton(
              text: "Sign Up",
              onPressed: () {
                // Handle sign up logic
              },
            ),
            SizedBox(height: 16.h),

            // Login Redirect
            TextButton(
              onPressed: () {
                context.go("/login"); // or use named route to go to login
              },
              child: Text(
                "Already have an account? Login",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
