import 'package:equatable/equatable.dart';

class GroceryStore extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final double deliveryFee;
  final bool isOpen;
  final List<String> categories;
  final String? address;
  final String? phone;
  final double? minOrder;
  final bool isExpressDelivery; // 30-min delivery
  final List<String> paymentMethods;

  const GroceryStore({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.isOpen,
    required this.categories,
    this.address,
    this.phone,
    this.minOrder,
    this.isExpressDelivery = false,
    this.paymentMethods = const ['Cash', 'Card', 'UPI'],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        rating,
        deliveryTime,
        deliveryFee,
        isOpen,
        categories,
        address,
        phone,
        minOrder,
        isExpressDelivery,
        paymentMethods,
      ];

  // Sample data
  static List<GroceryStore> get sampleStores => const [
        GroceryStore(
          id: '1',
          name: 'FreshMart',
          description: 'Fresh groceries and daily essentials',
          imageUrl:
              'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400',
          rating: 4.5,
          deliveryTime: '15-30 min',
          deliveryFee: 20.0,
          isOpen: true,
          categories: ['Vegetables', 'Fruits', 'Dairy', 'Snacks'],
          address: 'MG Road, Kochi',
          phone: '+91 9876543210',
          minOrder: 100.0,
          isExpressDelivery: true,
        ),
        GroceryStore(
          id: '2',
          name: 'SuperValue',
          description: 'Everything you need for your home',
          imageUrl:
              'https://images.unsplash.com/photo-1604719312566-8912dc6ab05f?w=400',
          rating: 4.3,
          deliveryTime: '30-45 min',
          deliveryFee: 25.0,
          isOpen: true,
          categories: ['Household', 'Beverages', 'Personal Care', 'Frozen'],
          address: 'Panampilly Nagar, Kochi',
          phone: '+91 9876543211',
          minOrder: 150.0,
        ),
        GroceryStore(
          id: '3',
          name: 'Organic Heaven',
          description: '100% organic and natural products',
          imageUrl:
              'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
          rating: 4.7,
          deliveryTime: '45-60 min',
          deliveryFee: 30.0,
          isOpen: true,
          categories: ['Organic', 'Health Foods', 'Supplements'],
          address: 'Edapally, Kochi',
          phone: '+91 9876543212',
          minOrder: 200.0,
        ),
      ];
}
