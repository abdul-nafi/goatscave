import 'package:equatable/equatable.dart';

class FoodCategory extends Equatable {
  final String id;
  final String name;
  final String icon;
  final int itemCount;

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
