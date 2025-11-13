import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:goatscave/features/food/food.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(const FoodState()) {
    on<LoadAllRestaurants>(_onLoadAllRestaurants);
    on<LoadRestaurantDetail>(_onLoadRestaurantDetail);
    on<SearchFoodAndRestaurants>(_onSearchFoodAndRestaurants);
    on<FilterByCategory>(_onFilterByCategory);
    on<LoadFoodCategories>(_onLoadFoodCategories);
    on<ClearFoodFilters>(_onClearFilters);
    on<LoadRestaurantMenu>(_onLoadRestaurantMenu);
    on<FilterMenuByCategory>(_onFilterMenuByCategory);
    on<SearchMenuItems>(_onSearchMenuItems);
    on<ClearMenuFilter>(_onClearMenuFilter);
    on<AddToCart>(_onAddToCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<ClearCart>(_onClearCart);

    // Remove these events as they're redundant:
    // - LoadRestaurants (replaced by LoadAllRestaurants)
    // - SearchRestaurants (replaced by SearchFoodAndRestaurants)
    // - ToggleRestaurantFavorite (not needed for basic functionality)
    // - ToggleFoodItemFavorite (not needed for basic functionality)
  }

  // NEW: Load all restaurants with menus for search functionality
  void _onLoadAllRestaurants(
    LoadAllRestaurants event,
    Emitter<FoodState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FoodStatus.loading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final restaurants = Restaurant.sampleRestaurants;

      // Pre-load menus for all restaurants for search functionality
      final restaurantMenus = <String, List<FoodItem>>{};
      final allMenuItems = FoodItem.sampleItems;

      // Group menu items by restaurant - FIXED: using restaurantId
      for (final restaurant in restaurants) {
        final restaurantMenu = allMenuItems
            .where(
                (item) => item.restaurantId == restaurant.id) // Now this works!
            .toList();
        restaurantMenus[restaurant.id] = restaurantMenu;
      }

      emit(state.copyWith(
        restaurants: restaurants,
        filteredRestaurants: restaurants,
        restaurantMenus: restaurantMenus,
        status: FoodStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FoodStatus.error,
        errorMessage: 'Failed to load restaurants: ${e.toString()}',
      ));
    }
  }

  void _onLoadRestaurantDetail(
    LoadRestaurantDetail event,
    Emitter<FoodState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FoodStatus.restaurantDetailLoading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      final restaurant = state.restaurants.firstWhere(
        (r) => r.id == event.restaurantId,
        orElse: () => Restaurant.sampleRestaurants.first,
      );

      emit(state.copyWith(
        selectedRestaurant: restaurant,
        status: FoodStatus.restaurantDetailSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FoodStatus.error,
        errorMessage: 'Failed to load restaurant details: ${e.toString()}',
      ));
    }
  }

  // UPDATED: Robust search across restaurants and food items
  void _onSearchFoodAndRestaurants(
    SearchFoodAndRestaurants event,
    Emitter<FoodState> emit,
  ) {
    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      emit(state.copyWith(
        searchResults: [],
        searchQuery: '',
        isSearching: false,
      ));
      return;
    }

    emit(state.copyWith(
      isSearching: true,
      searchQuery: query,
    ));

    try {
      // Use the robust search service
      final results = FoodSearchService.searchAll(
        query: query,
        restaurants: state.restaurants,
        restaurantMenus: state.restaurantMenus,
      );

      emit(state.copyWith(
        searchResults: results,
        isSearching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSearching: false,
        status: FoodStatus.error,
        errorMessage: 'Search failed: ${e.toString()}',
      ));
    }
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<FoodState> emit) {
    if (event.category == state.selectedCategory) {
      // If same category clicked, clear filter
      emit(state.copyWith(
        filteredRestaurants: state.restaurants,
        selectedCategory: null,
      ));
    } else {
      final filtered = state.restaurants.where((restaurant) {
        return restaurant.categories.contains(event.category);
      }).toList();

      emit(state.copyWith(
        filteredRestaurants: filtered,
        selectedCategory: event.category,
      ));
    }
  }

  void _onLoadFoodCategories(
    LoadFoodCategories event,
    Emitter<FoodState> emit,
  ) {
    final categories = FoodCategory.sampleCategories;
    emit(state.copyWith(categories: categories));
  }

  void _onClearFilters(ClearFoodFilters event, Emitter<FoodState> emit) {
    emit(state.copyWith(
      filteredRestaurants: state.restaurants,
      selectedCategory: null,
      searchQuery: '',
      searchResults: [],
      isSearching: false,
    ));
  }

  void _onLoadRestaurantMenu(
    LoadRestaurantMenu event,
    Emitter<FoodState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FoodStatus.loading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Get menu for specific restaurant from cached menus
      final menu =
          state.restaurantMenus[event.restaurantId] ?? FoodItem.sampleItems;

      emit(state.copyWith(
        restaurantMenu: menu,
        filteredMenu: menu,
        status: FoodStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FoodStatus.error,
        errorMessage: 'Failed to load menu: ${e.toString()}',
      ));
    }
  }

  void _onFilterMenuByCategory(
    FilterMenuByCategory event,
    Emitter<FoodState> emit,
  ) {
    if (event.category == state.selectedMenuCategory) {
      // Clear filter if same category clicked
      emit(state.copyWith(
        filteredMenu: state.restaurantMenu,
        selectedMenuCategory: null,
      ));
    } else {
      final filtered = state.restaurantMenu.where((item) {
        return item.category == event.category;
      }).toList();

      emit(state.copyWith(
        filteredMenu: filtered,
        selectedMenuCategory: event.category,
      ));
    }
  }

  // NEW: Clear menu filter
  void _onClearMenuFilter(ClearMenuFilter event, Emitter<FoodState> emit) {
    emit(state.copyWith(
      filteredMenu: state.restaurantMenu,
      selectedMenuCategory: null,
      menuSearchQuery: '',
    ));
  }

  void _onSearchMenuItems(SearchMenuItems event, Emitter<FoodState> emit) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      // Apply category filter if active
      final filtered = state.selectedMenuCategory != null
          ? state.restaurantMenu
              .where((item) => item.category == state.selectedMenuCategory)
              .toList()
          : state.restaurantMenu;

      emit(state.copyWith(
        filteredMenu: filtered,
        menuSearchQuery: '',
      ));
      return;
    }

    final filtered = state.restaurantMenu.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(
      filteredMenu: filtered,
      menuSearchQuery: query,
    ));
  }

  void _onAddToCart(AddToCart event, Emitter<FoodState> emit) {
    final updatedQuantities = Map<String, int>.from(state.cartQuantities);
    updatedQuantities[event.itemId] =
        (updatedQuantities[event.itemId] ?? 0) + event.quantity;

    emit(state.copyWith(cartQuantities: updatedQuantities));
  }

  void _onUpdateCartQuantity(
    UpdateCartQuantity event,
    Emitter<FoodState> emit,
  ) {
    final updatedQuantities = Map<String, int>.from(state.cartQuantities);

    if (event.quantity <= 0) {
      updatedQuantities.remove(event.itemId);
    } else {
      updatedQuantities[event.itemId] = event.quantity;
    }

    emit(state.copyWith(cartQuantities: updatedQuantities));
  }

  void _onClearCart(ClearCart event, Emitter<FoodState> emit) {
    emit(state.copyWith(cartQuantities: {}));
  }

  // Cart manipulation helpers
  void addToCart(String itemId, {int quantity = 1}) {
    add(AddToCart(itemId, quantity));
  }

  void updateCartQuantity(String itemId, int quantity) {
    add(UpdateCartQuantity(itemId, quantity));
  }

  void clearCart() {
    add(const ClearCart());
  }
}
