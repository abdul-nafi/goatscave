import '../food.dart';

class FoodSearchService {
  // Search across restaurants and their menus
  static List<SearchResult> searchAll({
    required String query,
    required List<Restaurant> restaurants,
    required Map<String, List<FoodItem>> restaurantMenus,
  }) {
    if (query.isEmpty) return [];

    final results = <SearchResult>[];
    final lowerQuery = query.toLowerCase().trim();

    // Search restaurants
    for (final restaurant in restaurants) {
      // Search restaurant name and description
      if (_matchesRestaurant(restaurant, lowerQuery)) {
        results.add(SearchResult(
          type: SearchResultType.restaurant,
          restaurant: restaurant,
          relevance: _calculateRestaurantRelevance(restaurant, lowerQuery),
        ));
      }

      // Search restaurant menu items
      final menu = restaurantMenus[restaurant.id];
      if (menu != null) {
        for (final foodItem in menu) {
          if (_matchesFoodItem(foodItem, lowerQuery)) {
            results.add(SearchResult(
              type: SearchResultType.foodItem,
              restaurant: restaurant,
              foodItem: foodItem,
              relevance: _calculateFoodItemRelevance(foodItem, lowerQuery),
            ));
          }
        }
      }
    }

    // Sort by relevance (higher relevance first)
    results.sort((a, b) => b.relevance.compareTo(a.relevance));

    return results;
  }

  static bool _matchesRestaurant(Restaurant restaurant, String query) {
    return restaurant.name.toLowerCase().contains(query) ||
        restaurant.description.toLowerCase().contains(query) ||
        restaurant.categories
            .any((category) => category.toLowerCase().contains(query)) ||
        (restaurant.address?.toLowerCase().contains(query) ?? false);
  }

  static bool _matchesFoodItem(FoodItem foodItem, String query) {
    return foodItem.name.toLowerCase().contains(query) ||
        foodItem.description.toLowerCase().contains(query) ||
        foodItem.category.toLowerCase().contains(query) ||
        (foodItem.tags?.any((tag) => tag.toLowerCase().contains(query)) ??
            false);
  }

  static double _calculateRestaurantRelevance(
      Restaurant restaurant, String query) {
    double relevance = 0.0;

    // Name matches are most important
    if (restaurant.name.toLowerCase().contains(query)) {
      relevance += 3.0;
      // Exact match in name gets highest priority
      if (restaurant.name.toLowerCase() == query) relevance += 2.0;
    }

    // Description matches
    if (restaurant.description.toLowerCase().contains(query)) {
      relevance += 1.5;
    }

    // Category matches
    if (restaurant.categories.any((c) => c.toLowerCase().contains(query))) {
      relevance += 1.0;
    }

    // Address matches
    if (restaurant.address?.toLowerCase().contains(query) ?? false) {
      relevance += 0.5;
    }

    // Boost by rating (higher rated restaurants get boost)
    relevance += restaurant.rating * 0.1;

    return relevance;
  }

  static double _calculateFoodItemRelevance(FoodItem foodItem, String query) {
    double relevance = 0.0;

    // Name matches are most important
    if (foodItem.name.toLowerCase().contains(query)) {
      relevance += 3.0;
      // Exact match in name gets highest priority
      if (foodItem.name.toLowerCase() == query) relevance += 2.0;
    }

    // Description matches
    if (foodItem.description.toLowerCase().contains(query)) {
      relevance += 2.0;
    }

    // Category matches
    if (foodItem.category.toLowerCase().contains(query)) {
      relevance += 1.5;
    }

    // Tag matches
    if (foodItem.tags?.any((tag) => tag.toLowerCase().contains(query)) ??
        false) {
      relevance += 1.0;
    }

    // Boost by rating and popularity
    relevance += (foodItem.rating ?? 0) * 0.2;
    if (foodItem.isPopular) relevance += 0.5;
    if (foodItem.hasDiscount) relevance += 0.3;

    return relevance;
  }
}

enum SearchResultType {
  restaurant,
  foodItem,
}

class SearchResult {
  final SearchResultType type;
  final Restaurant restaurant;
  final FoodItem? foodItem;
  final double relevance;

  SearchResult({
    required this.type,
    required this.restaurant,
    this.foodItem,
    required this.relevance,
  });

  String get displayName {
    return type == SearchResultType.restaurant
        ? restaurant.name
        : foodItem!.name;
  }

  String get displayDescription {
    return type == SearchResultType.restaurant
        ? restaurant.description
        : '${foodItem!.description} • ${restaurant.name}';
  }

  String get imageUrl {
    return type == SearchResultType.restaurant
        ? restaurant.imageUrl
        : foodItem!.imageUrl;
  }
}
