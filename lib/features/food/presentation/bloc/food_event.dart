part of 'food_bloc.dart';

@immutable
abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

// Restaurant Events
class LoadAllRestaurants extends FoodEvent {
  const LoadAllRestaurants();
}

class LoadRestaurantDetail extends FoodEvent {
  final String restaurantId;

  const LoadRestaurantDetail(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}

class SearchFoodAndRestaurants extends FoodEvent {
  final String query;

  const SearchFoodAndRestaurants(this.query);

  @override
  List<Object> get props => [query];
}

class FilterByCategory extends FoodEvent {
  final String category;

  const FilterByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class LoadFoodCategories extends FoodEvent {
  const LoadFoodCategories();
}

class ClearFoodFilters extends FoodEvent {
  const ClearFoodFilters();
}

// Menu Events
class LoadRestaurantMenu extends FoodEvent {
  final String restaurantId;

  const LoadRestaurantMenu(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}

class FilterMenuByCategory extends FoodEvent {
  final String category;

  const FilterMenuByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class ClearMenuFilter extends FoodEvent {
  const ClearMenuFilter();
}

class SearchMenuItems extends FoodEvent {
  final String query;

  const SearchMenuItems(this.query);

  @override
  List<Object> get props => [query];
}

// Cart Events
class AddToCart extends FoodEvent {
  final String itemId;
  final int quantity;

  const AddToCart(this.itemId, this.quantity);

  @override
  List<Object> get props => [itemId, quantity];
}

class UpdateCartQuantity extends FoodEvent {
  final String itemId;
  final int quantity;

  const UpdateCartQuantity(this.itemId, this.quantity);

  @override
  List<Object> get props => [itemId, quantity];
}

class ClearCart extends FoodEvent {
  const ClearCart();
}

// REMOVED EVENTS (no longer needed):
// - LoadRestaurants (use LoadAllRestaurants instead)
// - SearchRestaurants (use SearchFoodAndRestaurants instead)
// - ToggleRestaurantFavorite
// - ToggleFoodItemFavorite
