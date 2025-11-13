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
  });

  double get finalPrice => discountPrice ?? price;
  double get totalPrice => finalPrice * quantity;

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
      ];

  CartItem copyWith({
    int? quantity,
    double? price,
    double? discountPrice,
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

  @override
  List<Object?> get props => [items];

  Cart addItem(CartItem newItem) {
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
    return Cart(
      items: items.where((item) => item.id != itemId).toList(),
    );
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

  List<CartItem> getFoodItems() {
    return items.where((item) => item.type == ProductType.food).toList();
  }

  List<CartItem> getGroceryItems() {
    return items.where((item) => item.type == ProductType.grocery).toList();
  }

  bool get hasMixedRestaurants {
    final restaurantIds = items
        .where((item) => item.restaurantId != null)
        .map((item) => item.restaurantId!)
        .toSet();
    return restaurantIds.length > 1;
  }
}
