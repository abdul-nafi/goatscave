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

  const FoodState({
    this.restaurants = const [],
    this.filteredRestaurants = const [],
    this.selectedRestaurant,
    this.categories = const [],
    this.selectedCategory,
    this.searchQuery = '',
    this.status = FoodStatus.initial,
    this.errorMessage,
  });

  bool get isLoading => status == FoodStatus.loading;
  bool get hasError => status == FoodStatus.error;
  bool get hasRestaurants => filteredRestaurants.isNotEmpty;

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
    );
  }
}

enum FoodStatus {
  initial,
  loading,
  success,
  error,
  restaurantDetailLoading,
  restaurantDetailSuccess,
}
