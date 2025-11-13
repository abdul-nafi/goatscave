part of 'food_bloc.dart';

@immutable
class FoodState extends Equatable {
  final List<Restaurant> restaurants;
  final List<Restaurant> filteredRestaurants;
  final Restaurant? selectedRestaurant;
  final List<FoodCategory> categories;
  final String? selectedCategory;
  final String searchQuery;
  final FoodStatus status;
  final String? errorMessage;
  final List<FoodItem> restaurantMenu;
  final List<FoodItem> filteredMenu;
  final String? selectedMenuCategory;
  final String menuSearchQuery;
  final Map<String, int> cartQuantities;
  final List<SearchResult> searchResults;
  final Map<String, List<FoodItem>> restaurantMenus;
  final bool isSearching;

  const FoodState({
    this.restaurants = const [],
    this.filteredRestaurants = const [],
    this.selectedRestaurant,
    this.categories = const [],
    this.selectedCategory,
    this.searchQuery = '',
    this.status = FoodStatus.initial,
    this.errorMessage,
    this.restaurantMenu = const [],
    this.filteredMenu = const [],
    this.selectedMenuCategory,
    this.menuSearchQuery = '',
    this.cartQuantities = const {},
    this.searchResults = const [],
    this.restaurantMenus = const {},
    this.isSearching = false,
  });

  bool get isLoading => status == FoodStatus.loading;
  bool get hasError => status == FoodStatus.error;
  bool get hasRestaurants => filteredRestaurants.isNotEmpty;
  bool get hasMenuItems => filteredMenu.isNotEmpty;
  bool get hasSearchResults => searchResults.isNotEmpty;
  int get cartItemCount =>
      cartQuantities.values.fold(0, (sum, quantity) => sum + quantity);
  double get cartTotalAmount {
    return restaurantMenu.fold(0.0, (total, item) {
      final quantity = cartQuantities[item.id] ?? 0;
      return total + (item.finalPrice * quantity);
    });
  }

  @override
  List<Object?> get props => [
        restaurants,
        filteredRestaurants,
        selectedRestaurant,
        categories,
        selectedCategory,
        searchQuery,
        status,
        errorMessage,
        restaurantMenu,
        filteredMenu,
        selectedMenuCategory,
        menuSearchQuery,
        cartQuantities,
        searchResults,
        restaurantMenus,
        isSearching,
      ];

  FoodState copyWith({
    List<Restaurant>? restaurants,
    List<Restaurant>? filteredRestaurants,
    Restaurant? selectedRestaurant,
    List<FoodCategory>? categories,
    String? selectedCategory,
    String? searchQuery,
    FoodStatus? status,
    String? errorMessage,
    List<FoodItem>? restaurantMenu,
    List<FoodItem>? filteredMenu,
    String? selectedMenuCategory,
    String? menuSearchQuery,
    Map<String, int>? cartQuantities,
    List<SearchResult>? searchResults,
    Map<String, List<FoodItem>>? restaurantMenus,
    bool? isSearching,
  }) {
    return FoodState(
        restaurants: restaurants ?? this.restaurants,
        filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
        selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
        categories: categories ?? this.categories,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        searchQuery: searchQuery ?? this.searchQuery,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        restaurantMenu: restaurantMenu ?? this.restaurantMenu,
        filteredMenu: filteredMenu ?? this.filteredMenu,
        selectedMenuCategory: selectedMenuCategory ?? this.selectedMenuCategory,
        menuSearchQuery: menuSearchQuery ?? this.menuSearchQuery,
        cartQuantities: cartQuantities ?? this.cartQuantities,
        searchResults: searchResults ?? this.searchResults,
        restaurantMenus: restaurantMenus ?? this.restaurantMenus,
        isSearching: isSearching ?? this.isSearching);
  }
}

enum FoodStatus {
  initial,
  loading,
  success,
  error,
  restaurantDetailLoading,
  restaurantDetailSuccess,
  searching
}
