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
        Restaurant(
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
        Restaurant(
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
        Restaurant(
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
        Restaurant(
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
        Restaurant(
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

class FoodCategory extends Equatable {
  final String id;
  final String name;
  final String icon;
  final int itemCount; // Added for category stats

  const FoodCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.itemCount = 0,
  });

  @override
  List<Object> get props => [id, name, icon, itemCount];

  static List<FoodCategory> get sampleCategories => [
        const FoodCategory(id: '1', name: 'All', icon: '🍽️', itemCount: 25),
        const FoodCategory(id: '2', name: 'Indian', icon: '🇮🇳', itemCount: 8),
        const FoodCategory(id: '3', name: 'Chinese', icon: '🥡', itemCount: 5),
        const FoodCategory(id: '4', name: 'Italian', icon: '🍝', itemCount: 4),
        const FoodCategory(id: '5', name: 'Burgers', icon: '🍔', itemCount: 3),
        const FoodCategory(id: '6', name: 'Pizza', icon: '🍕', itemCount: 3),
        const FoodCategory(id: '7', name: 'Kerala', icon: '🍛', itemCount: 6),
        const FoodCategory(id: '8', name: 'Desserts', icon: '🍨', itemCount: 7),
        const FoodCategory(
            id: '9', name: 'Beverages', icon: '🥤', itemCount: 10),
      ];
}

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
  final bool isAvailable; // Added for availability
  final double? rating; // Added for item ratings
  final int reviewCount; // Added for review stats

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
  });

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get finalPrice => discountPrice ?? price;
  double get discountPercentage =>
      hasDiscount ? ((price - finalPrice) / price * 100) : 0;

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
    );
  }

  // Sample food items
  static List<FoodItem> get sampleItems => [
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
        ),
        FoodItem(
          id: '4',
          name: 'Garlic Naan',
          description: 'Soft tandoor bread with fresh garlic and butter',
          price: 60.0,
          imageUrl:
              'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400',
          category: 'Breads',
          isVegetarian: true,
          isSpicy: false,
          preparationTime: 10,
          rating: 4.2,
          reviewCount: 87,
        ),
        FoodItem(
          id: '5',
          name: 'Mango Lassi',
          description: 'Refreshing yogurt drink with sweet mango pulp',
          price: 80.0,
          discountPrice: 65.0,
          imageUrl:
              'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=400',
          category: 'Beverages',
          isVegetarian: true,
          isSpicy: false,
          preparationTime: 5,
          rating: 4.6,
          reviewCount: 156,
        ),
        FoodItem(
          id: '6',
          name: 'Chicken Tikka',
          description: 'Grilled chicken chunks marinated in spices and yogurt',
          price: 180.0,
          discountPrice: 150.0,
          imageUrl:
              'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
          category: 'Starters',
          isVegetarian: false,
          isSpicy: true,
          preparationTime: 15,
          rating: 4.4,
          reviewCount: 134,
        ),
        FoodItem(
          id: '7',
          name: 'Gulab Jamun',
          description: 'Sweet fried dough balls in rose-flavored sugar syrup',
          price: 120.0,
          imageUrl:
              'https://images.unsplash.com/photo-1586444248902-2f64eddc13df?w=400',
          category: 'Desserts',
          isVegetarian: true,
          isSpicy: false,
          preparationTime: 5,
          rating: 4.8,
          reviewCount: 98,
        ),
        FoodItem(
          id: '8',
          name: 'Masala Dosa',
          description:
              'Crispy rice crepe with spiced potato filling, served with sambar',
          price: 90.0,
          imageUrl:
              'https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=400',
          category: 'Main Course',
          isVegetarian: true,
          isSpicy: false,
          preparationTime: 12,
          addons: ['Coconut Chutney', 'Sambar', 'Potato Masala'],
          rating: 4.5,
          reviewCount: 178,
        ),
      ];
}
