import 'package:equatable/equatable.dart';

enum ProductType { food, grocery, taxi }

class CartItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final ProductType type;
  final String? imageUrl;
  final String? restaurantId;
  final String? storeId;
  final Map<String, dynamic>? variants;
  final double? discountPrice;
  final String? unit; // ADDED: For grocery items (kg, l, etc.)
  final double? unitValue; // ADDED: For grocery items (1, 0.5, etc.)
  final String? brand; // ADDED: For grocery items

  const CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.type,
    this.imageUrl,
    this.restaurantId,
    this.storeId,
    this.variants,
    this.discountPrice,
    this.unit, // ADDED
    this.unitValue, // ADDED
    this.brand, // ADDED
  });

  double get finalPrice => discountPrice ?? price;
  double get totalPrice => finalPrice * quantity;

  // ADDED: Display name with unit for grocery items
  String get displayName {
    if (type == ProductType.grocery && unit != null && unitValue != null) {
      return '$name ($unitValue$unit)';
    }
    return name;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    quantity,
    type,
    imageUrl,
    restaurantId,
    storeId,
    variants,
    discountPrice,
    unit, // ADDED
    unitValue, // ADDED
    brand, // ADDED
  ];

  CartItem copyWith({
    int? quantity,
    double? price,
    double? discountPrice,
    String? unit, // ADDED
    double? unitValue, // ADDED
    String? brand, // ADDED
  }) {
    return CartItem(
      id: id,
      name: name,
      description: description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      type: type,
      imageUrl: imageUrl,
      restaurantId: restaurantId,
      storeId: storeId,
      variants: variants,
      discountPrice: discountPrice ?? this.discountPrice,
      unit: unit ?? this.unit, // ADDED
      unitValue: unitValue ?? this.unitValue, // ADDED
      brand: brand ?? this.brand, // ADDED
    );
  }

  // Convert FoodItem to CartItem
  factory CartItem.fromFoodItem(
    String id,
    String name,
    String description,
    double price, {
    int quantity = 1,
    String? imageUrl,
    String? restaurantId,
    double? discountPrice,
    String? category,
    bool? isVegetarian,
    bool? isSpicy,
    int? preparationTime,
  }) {
    return CartItem(
      id: id,
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      type: ProductType.food,
      imageUrl: imageUrl,
      restaurantId: restaurantId,
      discountPrice: discountPrice,
      variants: {
        'category': category,
        'isVegetarian': isVegetarian,
        'isSpicy': isSpicy,
        'preparationTime': preparationTime,
      },
    );
  }

  // ADDED: Convert GroceryItem to CartItem
  factory CartItem.fromGroceryItem(
    String id,
    String name,
    String description,
    double price, {
    int quantity = 1,
    String? imageUrl,
    String? storeId,
    String? unit,
    double? unitValue,
    String? brand,
    double? discountPrice,
  }) {
    return CartItem(
      id: id,
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      type: ProductType.grocery,
      imageUrl: imageUrl,
      storeId: storeId,
      discountPrice: discountPrice,
      unit: unit, // ADDED
      unitValue: unitValue, // ADDED
      brand: brand, // ADDED
      variants: {'unit': unit, 'unitValue': unitValue, 'brand': brand},
    );
  }

  // ADDED: Helper method to check if item is from a specific store/restaurant
  bool isFromSameVendor(String? vendorId) {
    if (type == ProductType.food) {
      return restaurantId == vendorId;
    } else if (type == ProductType.grocery) {
      return storeId == vendorId;
    }
    return true; // For taxi, no vendor restriction
  }
}

class Cart extends Equatable {
  final List<CartItem> items;

  const Cart({required this.items});

  double get totalAmount {
    return items.fold(0, (total, item) => total + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  // ADDED: Get items grouped by vendor
  Map<String, List<CartItem>> get itemsByVendor {
    final Map<String, List<CartItem>> grouped = {};

    for (final item in items) {
      String vendorId = '';
      if (item.type == ProductType.food) {
        vendorId = 'food_${item.restaurantId ?? 'unknown'}';
      } else if (item.type == ProductType.grocery) {
        vendorId = 'grocery_${item.storeId ?? 'unknown'}';
      } else {
        vendorId = 'taxi_unknown';
      }

      if (!grouped.containsKey(vendorId)) {
        grouped[vendorId] = [];
      }
      grouped[vendorId]!.add(item);
    }

    return grouped;
  }

  @override
  List<Object?> get props => [items];

  Cart addItem(CartItem newItem) {
    // Check if we're adding items from different vendors
    if (items.isNotEmpty) {
      final firstItem = items.first;
      if (!firstItem.isFromSameVendor(
        newItem.type == ProductType.food
            ? newItem.restaurantId
            : newItem.storeId,
      )) {
        // If different vendor, clear cart and add new item
        return Cart(items: [newItem]);
      }
    }

    final existingItemIndex = items.indexWhere((item) => item.id == newItem.id);

    if (existingItemIndex != -1) {
      // Update quantity if item exists
      final updatedItems = List<CartItem>.from(items);
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + newItem.quantity,
      );
      return Cart(items: updatedItems);
    } else {
      // Add new item
      return Cart(items: [...items, newItem]);
    }
  }

  Cart removeItem(String itemId) {
    return Cart(items: items.where((item) => item.id != itemId).toList());
  }

  Cart updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      return removeItem(itemId);
    }

    return Cart(
      items: items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList(),
    );
  }

  Cart clear() {
    return const Cart(items: []);
  }

  // ADDED: Clear items by vendor type
  Cart clearByType(ProductType type) {
    return Cart(items: items.where((item) => item.type != type).toList());
  }

  List<CartItem> getFoodItems() {
    return items.where((item) => item.type == ProductType.food).toList();
  }

  List<CartItem> getGroceryItems() {
    return items.where((item) => item.type == ProductType.grocery).toList();
  }

  List<CartItem> getTaxiItems() {
    return items.where((item) => item.type == ProductType.taxi).toList();
  }

  bool get hasMixedVendors {
    final vendorIds = <String>{};

    for (final item in items) {
      if (item.type == ProductType.food) {
        vendorIds.add('food_${item.restaurantId ?? 'unknown'}');
      } else if (item.type == ProductType.grocery) {
        vendorIds.add('grocery_${item.storeId ?? 'unknown'}');
      } else {
        vendorIds.add('taxi_unknown');
      }
    }

    return vendorIds.length > 1;
  }

  // ADDED: Check if cart has items from specific vendor
  bool hasItemsFromVendor(String? vendorId, ProductType type) {
    return items.any((item) {
      if (item.type != type) return false;
      if (type == ProductType.food) {
        return item.restaurantId == vendorId;
      } else if (type == ProductType.grocery) {
        return item.storeId == vendorId;
      }
      return false;
    });
  }

  // ADDED: Get primary vendor info
  Map<String, dynamic>? get primaryVendor {
    if (items.isEmpty) return null;

    final firstItem = items.first;
    if (firstItem.type == ProductType.food) {
      return {
        'type': 'food',
        'id': firstItem.restaurantId,
        'name': 'Restaurant', // You might want to pass actual restaurant name
      };
    } else if (firstItem.type == ProductType.grocery) {
      return {
        'type': 'grocery',
        'id': firstItem.storeId,
        'name': 'Grocery Store', // You might want to pass actual store name
      };
    }

    return null;
  }
}
