class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final double deliveryFee;
  final bool isOpen;
  final List<String> categories;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.isOpen,
    required this.categories,
  });

  // Sample data for demo
  static List<Restaurant> get sampleRestaurants => [
        Restaurant(
          id: '1',
          name: 'Spice Garden',
          description: 'Authentic Indian Cuisine',
          imageUrl:
              'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
          rating: 4.5,
          deliveryTime: '25-35 min',
          deliveryFee: 25.0,
          isOpen: true,
          categories: ['Indian', 'Biryani', 'Vegetarian'],
        ),
        Restaurant(
          id: '2',
          name: 'Burger Hub',
          description: 'Gourmet Burgers & Fries',
          imageUrl:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
          rating: 4.2,
          deliveryTime: '20-30 min',
          deliveryFee: 30.0,
          isOpen: true,
          categories: ['Burgers', 'American', 'Fast Food'],
        ),
        Restaurant(
          id: '3',
          name: 'Pizza Palace',
          description: 'Wood Fired Pizzas',
          imageUrl:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
          rating: 4.7,
          deliveryTime: '30-40 min',
          deliveryFee: 35.0,
          isOpen: true,
          categories: ['Pizza', 'Italian', 'Desserts'],
        ),
      ];
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isVegetarian;
  final bool isSpicy;
  final int preparationTime;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isVegetarian,
    required this.isSpicy,
    required this.preparationTime,
  });
}
