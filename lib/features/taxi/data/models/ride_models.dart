class RideRequest {
  final String id;
  final String pickupLocation;
  final String dropoffLocation;
  final String vehicleType;
  final double estimatedFare;
  final DateTime createdAt;

  RideRequest({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.vehicleType,
    required this.estimatedFare,
    required this.createdAt,
  });

  // Add fromJson/toJson methods for API integration later
}
