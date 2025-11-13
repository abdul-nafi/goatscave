import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isVegetarian;
  final bool isSpicy;
  final int preparationTime;
  final List<String>? addons;
  final double? discountPrice;
  final bool isAvailable;
  final double? rating;
  final int reviewCount;
  final List<String>? tags;
  final String restaurantId; // ADD THIS FIELD

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isVegetarian,
    required this.isSpicy,
    required this.preparationTime,
    this.addons,
    this.discountPrice,
    this.isAvailable = true,
    this.rating,
    this.reviewCount = 0,
    this.tags,
    required this.restaurantId, // ADD THIS FIELD
  });

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get finalPrice => discountPrice ?? price;
  double get discountPercentage =>
      hasDiscount ? ((price - finalPrice) / price * 100) : 0;

  // Helper getter for search
  bool get isPopular => (rating ?? 0) >= 4.5;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        isVegetarian,
        isSpicy,
        preparationTime,
        addons,
        discountPrice,
        isAvailable,
        rating,
        reviewCount,
        restaurantId, // ADD THIS FIELD
      ];

  FoodItem copyWith({
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    bool? isVegetarian,
    bool? isSpicy,
    int? preparationTime,
    List<String>? addons,
    double? discountPrice,
    bool? isAvailable,
    double? rating,
    int? reviewCount,
    List<String>? tags,
    String? restaurantId,
  }) {
    return FoodItem(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isSpicy: isSpicy ?? this.isSpicy,
      preparationTime: preparationTime ?? this.preparationTime,
      addons: addons ?? this.addons,
      discountPrice: discountPrice ?? this.discountPrice,
      isAvailable: isAvailable ?? this.isAvailable,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      tags: tags ?? this.tags,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  // Sample food items - UPDATED with restaurantId
  static List<FoodItem> get sampleItems => const [
        FoodItem(
          id: '1',
          name: 'Butter Chicken',
          description: 'Tender chicken in rich tomato butter sauce with cream',
          price: 320.0,
          discountPrice: 280.0,
          imageUrl:
              'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400',
          category: 'Main Course',
          isVegetarian: false,
          isSpicy: true,
          preparationTime: 20,
          addons: ['Extra Gravy', 'Butter Naan', 'Raita'],
          rating: 4.5,
          reviewCount: 128,
          restaurantId: '1', // Spice Garden
        ),
        FoodItem(
          id: '2',
          name: 'Paneer Butter Masala',
          description: 'Cottage cheese in creamy tomato gravy with spices',
          price: 280.0,
          imageUrl:
              'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400',
          category: 'Main Course',
          isVegetarian: true,
          isSpicy: false,
          preparationTime: 15,
          rating: 4.3,
          reviewCount: 95,
          restaurantId: '1', // Spice Garden
        ),
        FoodItem(
          id: '3',
          name: 'Chicken Biryani',
          description:
              'Fragrant basmati rice with tender chicken pieces and spices',
          price: 250.0,
          imageUrl:
              'https://images.unsplash.com/photo-1563379091339-03246963d96f?w=400',
          category: 'Rice',
          isVegetarian: false,
          isSpicy: true,
          preparationTime: 25,
          addons: ['Raita', 'Salad', 'Mirchi Ka Salan'],
          rating: 4.7,
          reviewCount: 210,
          restaurantId: '1', // Spice Garden
        ),
        FoodItem(
          id: '4',
          name: 'Classic Burger',
          description: 'Beef patty with lettuce, tomato, and special sauce',
          price: 180.0,
          imageUrl:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
          category: 'Burgers',
          isVegetarian: false,
          isSpicy: false,
          preparationTime: 15,
          rating: 4.4,
          reviewCount: 156,
          restaurantId: '2', // Burger Hub
        ),
        FoodItem(
          id: '5',
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomato sauce and mozzarella',
          price: 300.0,
          discountPrice: 250.0,
          imageUrl:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
          category: 'Pizza',
          isVegetarian: true,
          isSpicy: false,
          preparationTime: 20,
          rating: 4.6,
          reviewCount: 189,
          restaurantId: '3', // Pizza Palace
        ),
        FoodItem(
          id: '6',
          name: 'Kung Pao Chicken',
          description: 'Spicy stir-fried chicken with peanuts and vegetables',
          price: 280.0,
          imageUrl:
              'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=400',
          category: 'Chinese',
          isVegetarian: false,
          isSpicy: true,
          preparationTime: 18,
          rating: 4.3,
          reviewCount: 134,
          restaurantId: '4', // Chinese Wok
        ),
        FoodItem(
          id: '7',
          name: 'Kerala Fish Curry',
          description: 'Traditional fish curry with coconut and spices',
          price: 220.0,
          imageUrl:
              'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
          category: 'Seafood',
          isVegetarian: false,
          isSpicy: true,
          preparationTime: 25,
          rating: 4.7,
          reviewCount: 178,
          restaurantId: '5', // Kerala Spices
        ),
      ];
}
