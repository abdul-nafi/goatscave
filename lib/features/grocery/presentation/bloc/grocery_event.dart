part of 'grocery_bloc.dart';

abstract class GroceryEvent extends Equatable {
  const GroceryEvent();

  @override
  List<Object> get props => [];
}

// Store Events
class LoadGroceryStores extends GroceryEvent {
  const LoadGroceryStores();
}

class LoadGroceryStoreDetail extends GroceryEvent {
  final String storeId;

  const LoadGroceryStoreDetail(this.storeId);

  @override
  List<Object> get props => [storeId];
}

class SearchGroceryStores extends GroceryEvent {
  final String query;

  const SearchGroceryStores(this.query);

  @override
  List<Object> get props => [query];
}

class FilterStoresByCategory extends GroceryEvent {
  final String category;

  const FilterStoresByCategory(this.category);

  @override
  List<Object> get props => [category];
}

// Item Events
class LoadStoreItems extends GroceryEvent {
  final String storeId;

  const LoadStoreItems(this.storeId);

  @override
  List<Object> get props => [storeId];
}

class FilterItemsByCategory extends GroceryEvent {
  final String category;

  const FilterItemsByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class SearchStoreItems extends GroceryEvent {
  final String query;

  const SearchStoreItems(this.query);

  @override
  List<Object> get props => [query];
}

class ClearItemFilters extends GroceryEvent {
  const ClearItemFilters();
}

// Cart Events
class AddGroceryToCart extends GroceryEvent {
  final String itemId;
  final int quantity;

  const AddGroceryToCart(this.itemId, this.quantity);

  @override
  List<Object> get props => [itemId, quantity];
}

class UpdateGroceryCartQuantity extends GroceryEvent {
  final String itemId;
  final int quantity;

  const UpdateGroceryCartQuantity(this.itemId, this.quantity);

  @override
  List<Object> get props => [itemId, quantity];
}

class ClearGroceryCart extends GroceryEvent {
  const ClearGroceryCart();
}

// Delivery Slot Events
class SelectDeliverySlot extends GroceryEvent {
  final DateTime slot;

  const SelectDeliverySlot(this.slot);

  @override
  List<Object> get props => [slot];
}
