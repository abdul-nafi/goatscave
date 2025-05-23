import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../user/user.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Services'),
        leading: IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.w),
        children: animatedActionButtons,
      ),
    );
  }
}
