import 'package:equatable/equatable.dart';

class GroceryCategory extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String color;
  final int itemCount;

  const GroceryCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.itemCount = 0,
  });

  @override
  List<Object> get props => [id, name, icon, color, itemCount];

  static List<GroceryCategory> get sampleCategories => [
        const GroceryCategory(
          id: '1',
          name: 'Fruits & Vegetables',
          icon: '🍎',
          color: '0xFF4CAF50',
          itemCount: 45,
        ),
        const GroceryCategory(
          id: '2',
          name: 'Dairy & Eggs',
          icon: '🥛',
          color: '0xFFFFF9C4',
          itemCount: 32,
        ),
        const GroceryCategory(
          id: '3',
          name: 'Meat & Fish',
          icon: '🍗',
          color: '0xFFEF5350',
          itemCount: 28,
        ),
        const GroceryCategory(
          id: '4',
          name: 'Beverages',
          icon: '🥤',
          color: '0xFF90CAF9',
          itemCount: 67,
        ),
        const GroceryCategory(
          id: '5',
          name: 'Snacks',
          icon: '🍪',
          color: '0xFFBCAAA4',
          itemCount: 89,
        ),
        const GroceryCategory(
          id: '6',
          name: 'Household',
          icon: '🏠',
          color: '0xFF78909C',
          itemCount: 56,
        ),
        const GroceryCategory(
          id: '7',
          name: 'Personal Care',
          icon: '🧴',
          color: '0xFFCE93D8',
          itemCount: 43,
        ),
        const GroceryCategory(
          id: '8',
          name: 'Baby Care',
          icon: '👶',
          color: '0xFF80DEEA',
          itemCount: 34,
        ),
      ];
}
