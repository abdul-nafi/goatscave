import 'package:equatable/equatable.dart';

class GroceryItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String unit; // kg, g, ml, piece, etc.
  final double unitValue;
  final bool isVegetarian;
  final bool isAvailable;
  final double? discountPrice;
  final String brand;
  final String storeId;
  final int stockQuantity;
  final double? rating;
  final int reviewCount;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.unit,
    required this.unitValue,
    required this.isVegetarian,
    required this.isAvailable,
    this.discountPrice,
    required this.brand,
    required this.storeId,
    required this.stockQuantity,
    this.rating,
    this.reviewCount = 0,
  });

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get finalPrice => discountPrice ?? price;
  bool get isOutOfStock => stockQuantity <= 0;
  String get displayPrice => '₹$finalPrice / $unitValue$unit';

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        unit,
        unitValue,
        isVegetarian,
        isAvailable,
        discountPrice,
        brand,
        storeId,
        stockQuantity,
        rating,
        reviewCount,
      ];

  // Sample data
  static List<GroceryItem> get sampleItems => const [
        GroceryItem(
          id: '1',
          name: 'Fresh Apples',
          description: 'Fresh red apples, sweet and juicy',
          price: 120.0,
          discountPrice: 99.0,
          imageUrl:
              'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=400',
          category: 'Fruits & Vegetables',
          unit: 'kg',
          unitValue: 1,
          isVegetarian: true,
          isAvailable: true,
          brand: 'Farm Fresh',
          storeId: '1',
          stockQuantity: 50,
          rating: 4.5,
          reviewCount: 128,
        ),
        GroceryItem(
          id: '2',
          name: 'Amul Milk',
          description: 'Pure cow milk, pasteurized',
          price: 60.0,
          imageUrl:
              'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400',
          category: 'Dairy & Eggs',
          unit: 'l',
          unitValue: 1,
          isVegetarian: true,
          isAvailable: true,
          brand: 'Amul',
          storeId: '1',
          stockQuantity: 30,
          rating: 4.7,
          reviewCount: 256,
        ),
        GroceryItem(
          id: '3',
          name: 'Chicken Breast',
          description: 'Fresh chicken breast, boneless',
          price: 280.0,
          imageUrl:
              'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=400',
          category: 'Meat & Fish',
          unit: 'kg',
          unitValue: 1,
          isVegetarian: false,
          isAvailable: true,
          brand: 'Fresh Poultry',
          storeId: '1',
          stockQuantity: 20,
          rating: 4.4,
          reviewCount: 89,
        ),
        GroceryItem(
          id: '4',
          name: 'Coca Cola',
          description: 'Refreshing soft drink',
          price: 90.0,
          discountPrice: 75.0,
          imageUrl:
              'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400',
          category: 'Beverages',
          unit: 'ml',
          unitValue: 750,
          isVegetarian: true,
          isAvailable: true,
          brand: 'Coca Cola',
          storeId: '2',
          stockQuantity: 100,
          rating: 4.3,
          reviewCount: 342,
        ),
      ];
}
