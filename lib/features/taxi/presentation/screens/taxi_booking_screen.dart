import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:goatscave/core/core.dart';

class TaxiBookingScreen extends StatefulWidget {
  const TaxiBookingScreen({super.key});

  @override
  State<TaxiBookingScreen> createState() => _TaxiBookingScreenState();
}

class _TaxiBookingScreenState extends State<TaxiBookingScreen> {
  String? pickupLocation;
  String? dropoffLocation;
  String selectedVehicle = 'auto';
  double estimatedFare = 0.0;

  final List<Map<String, dynamic>> vehicleTypes = [
    {
      'type': 'auto',
      'name': 'Auto Rickshaw',
      'icon': Icons.electric_rickshaw,
      'color': AppColors.taxiColor,
      'baseFare': 30.0,
      'perKm': 12.0,
    },
    {
      'type': 'car',
      'name': 'Car Taxi',
      'icon': Icons.local_taxi,
      'color': AppColors.primary,
      'baseFare': 50.0,
      'perKm': 15.0,
    },
    {
      'type': 'bike',
      'name': 'Bike Taxi',
      'icon': Icons.directions_bike,
      'color': AppColors.secondary,
      'baseFare': 20.0,
      'perKm': 8.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Ride',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/home'),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 64.sp,
                    color: AppColors.textTertiary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Live Map Coming Soon',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  SizedBox(height: 8.h),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement map integration
                      _showComingSoonDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.taxiColor,
                      foregroundColor: AppColors.textInverse,
                    ),
                    child: Text('Enable Location'),
                  ),
                ],
              ),
            ),
          ),

          // Booking Form
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 16.r,
                    offset: Offset(0, -4.h),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book Your Ride',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 24.h),

                    // Pickup Location
                    _buildLocationField(
                      context,
                      label: 'Pickup Location',
                      hint: 'Enter pickup location',
                      icon: Icons.my_location,
                      onTap: () => _selectLocation(context, isPickup: true),
                    ),
                    SizedBox(height: 16.h),

                    // Dropoff Location
                    _buildLocationField(
                      context,
                      label: 'Dropoff Location',
                      hint: 'Enter destination',
                      icon: Icons.location_on,
                      onTap: () => _selectLocation(context, isPickup: false),
                    ),
                    SizedBox(height: 24.h),

                    // Vehicle Type Selection
                    Text(
                      'Choose Vehicle',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 12.h),
                    _buildVehicleSelection(),
                    SizedBox(height: 24.h),

                    // Fare Estimate
                    if (estimatedFare > 0) _buildFareEstimate(),
                    SizedBox(height: 24.h),

                    // Book Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canBookRide() ? _bookRide : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.taxiColor,
                          foregroundColor: AppColors.textInverse,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: Text(
                          'Book Ride - ₹${estimatedFare.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    hint,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: AppColors.textTertiary, size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleSelection() {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: vehicleTypes.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final vehicle = vehicleTypes[index];
          final isSelected = selectedVehicle == vehicle['type'];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedVehicle = vehicle['type'] as String;
                _calculateFare();
              });
            },
            child: Container(
              width: 100.w,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? vehicle['color'] as Color
                    : AppColors.background,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color:
                      isSelected ? vehicle['color'] as Color : AppColors.border,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    vehicle['icon'] as IconData,
                    color: isSelected
                        ? AppColors.textInverse
                        : vehicle['color'] as Color,
                    size: 24.sp,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    vehicle['name'] as String,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? AppColors.textInverse
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFareEstimate() {
    final vehicle =
        vehicleTypes.firstWhere((v) => v['type'] == selectedVehicle);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estimated Fare',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                '₹${estimatedFare.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.taxiColor,
                    ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                vehicle['name'] as String,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Base: ₹${vehicle['baseFare']}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _canBookRide() {
    return pickupLocation != null &&
        dropoffLocation != null &&
        estimatedFare > 0;
  }

  void _selectLocation(BuildContext context, {required bool isPickup}) {
    // TODO: Implement location selection with Google Places API
    _showComingSoonDialog(context);

    // For demo purposes, set dummy locations
    setState(() {
      if (isPickup) {
        pickupLocation = 'Kochi, Kerala';
      } else {
        dropoffLocation = 'Marine Drive, Kochi';
      }
      _calculateFare();
    });
  }

  void _calculateFare() {
    if (pickupLocation != null && dropoffLocation != null) {
      final vehicle =
          vehicleTypes.firstWhere((v) => v['type'] == selectedVehicle);
      // Simple fare calculation: base fare + (distance * per km rate)
      // For demo, using fixed distance of 5km
      const distance = 5.0;
      setState(() {
        estimatedFare = (vehicle['baseFare'] as double) +
            (distance * (vehicle['perKm'] as double));
      });
    }
  }

  void _bookRide() {
    // TODO: Implement actual booking logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ride Booked!'),
        content: Text(
            'Your ${vehicleTypes.firstWhere((v) => v['type'] == selectedVehicle)['name']} is on the way!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/home');
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Feature Coming Soon'),
        content: Text('This feature will be available in the next update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
