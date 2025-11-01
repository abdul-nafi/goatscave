part of 'food_bloc.dart';

@immutable
abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurants extends FoodEvent {
  final String? category;

  const LoadRestaurants({this.category});

  @override
  List<Object> get props => [category ?? ''];
}

class LoadRestaurantDetail extends FoodEvent {
  final String restaurantId;

  const LoadRestaurantDetail(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}

class SearchRestaurants extends FoodEvent {
  final String query;

  const SearchRestaurants(this.query);

  @override
  List<Object> get props => [query];
}

class FilterByCategory extends FoodEvent {
  final String category;

  const FilterByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class ToggleRestaurantFavorite extends FoodEvent {
  final String restaurantId;

  const ToggleRestaurantFavorite(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}

class LoadFoodCategories extends FoodEvent {}

class ClearFoodFilters extends FoodEvent {}
