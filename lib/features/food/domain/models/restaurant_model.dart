import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final double deliveryFee;
  final bool isOpen;
  final List<String> categories;
  final bool isFavorite; // Added for favorites
  final String? address; // Added for detailed info
  final String? phone; // Added for contact
  final double? minOrder; // Added for minimum order

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.isOpen,
    required this.categories,
    this.isFavorite = false,
    this.address,
    this.phone,
    this.minOrder,
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
        isFavorite,
        address,
        phone,
        minOrder,
      ];

  Restaurant copyWith({
    String? name,
    String? description,
    String? imageUrl,
    double? rating,
    String? deliveryTime,
    double? deliveryFee,
    bool? isOpen,
    List<String>? categories,
    bool? isFavorite,
    String? address,
    String? phone,
    double? minOrder,
  }) {
    return Restaurant(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      isOpen: isOpen ?? this.isOpen,
      categories: categories ?? this.categories,
      isFavorite: isFavorite ?? this.isFavorite,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      minOrder: minOrder ?? this.minOrder,
    );
  }

  // Sample data for demo
  static List<Restaurant> get sampleRestaurants => [
        const Restaurant(
          id: '1',
          name: 'Spice Garden',
          description: 'Authentic Indian Cuisine with traditional flavors',
          imageUrl:
              'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
          rating: 4.5,
          deliveryTime: '25-35 min',
          deliveryFee: 25.0,
          isOpen: true,
          categories: ['Indian', 'Biryani', 'Vegetarian', 'North Indian'],
          address: 'MG Road, Kochi',
          phone: '+91 9876543210',
          minOrder: 150.0,
        ),
        const Restaurant(
          id: '2',
          name: 'Burger Hub',
          description: 'Gourmet Burgers & Crispy Fries',
          imageUrl:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
          rating: 4.2,
          deliveryTime: '20-30 min',
          deliveryFee: 30.0,
          isOpen: true,
          categories: ['Burgers', 'American', 'Fast Food', 'Snacks'],
          address: 'Panampilly Nagar, Kochi',
          phone: '+91 9876543211',
          minOrder: 200.0,
        ),
        const Restaurant(
          id: '3',
          name: 'Pizza Palace',
          description: 'Wood Fired Pizzas & Italian Delights',
          imageUrl:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
          rating: 4.7,
          deliveryTime: '30-40 min',
          deliveryFee: 35.0,
          isOpen: true,
          categories: ['Pizza', 'Italian', 'Desserts', 'Fast Food'],
          address: 'Lulu Mall, Kochi',
          phone: '+91 9876543212',
          minOrder: 250.0,
        ),
        const Restaurant(
          id: '4',
          name: 'Chinese Wok',
          description: 'Authentic Chinese Cuisine',
          imageUrl:
              'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=400',
          rating: 4.3,
          deliveryTime: '35-45 min',
          deliveryFee: 40.0,
          isOpen: true,
          categories: ['Chinese', 'Asian', 'Noodles', 'Rice'],
          address: 'Edapally, Kochi',
          phone: '+91 9876543213',
          minOrder: 180.0,
        ),
        const Restaurant(
          id: '5',
          name: 'Kerala Spices',
          description: 'Traditional Kerala Meals & Seafood',
          imageUrl:
              'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
          rating: 4.6,
          deliveryTime: '40-50 min',
          deliveryFee: 20.0,
          isOpen: true,
          categories: ['Kerala', 'South Indian', 'Seafood', 'Traditional'],
          address: 'Fort Kochi, Kochi',
          phone: '+91 9876543214',
          minOrder: 120.0,
        ),
      ];
}
