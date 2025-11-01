import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:goatscave/features/food/food.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(const FoodState()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<LoadRestaurantDetail>(_onLoadRestaurantDetail);
    on<SearchRestaurants>(_onSearchRestaurants);
    on<FilterByCategory>(_onFilterByCategory);
    on<ToggleRestaurantFavorite>(_onToggleRestaurantFavorite);
    on<LoadFoodCategories>(_onLoadFoodCategories);
    on<ClearFoodFilters>(_onClearFilters);
  }

  void _onLoadRestaurants(
      LoadRestaurants event, Emitter<FoodState> emit) async {
    try {
      emit(state.copyWith(status: FoodStatus.loading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final restaurants = Restaurant.sampleRestaurants;

      // Apply category filter if provided
      List<Restaurant> filteredRestaurants = restaurants;
      if (event.category != null && event.category!.isNotEmpty) {
        filteredRestaurants = restaurants.where((restaurant) {
          return restaurant.categories.contains(event.category);
        }).toList();
      }

      emit(state.copyWith(
        restaurants: restaurants,
        filteredRestaurants: filteredRestaurants,
        status: FoodStatus.success,
        selectedCategory: event.category,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FoodStatus.error,
        errorMessage: 'Failed to load restaurants: ${e.toString()}',
      ));
    }
  }

  void _onLoadRestaurantDetail(
      LoadRestaurantDetail event, Emitter<FoodState> emit) async {
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

  void _onSearchRestaurants(SearchRestaurants event, Emitter<FoodState> emit) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        filteredRestaurants: state.restaurants,
        searchQuery: '',
      ));
      return;
    }

    final filtered = state.restaurants.where((restaurant) {
      return restaurant.name.toLowerCase().contains(query) ||
          restaurant.description.toLowerCase().contains(query) ||
          restaurant.categories
              .any((category) => category.toLowerCase().contains(query));
    }).toList();

    emit(state.copyWith(
      filteredRestaurants: filtered,
      searchQuery: query,
    ));
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

  void _onToggleRestaurantFavorite(
      ToggleRestaurantFavorite event, Emitter<FoodState> emit) {
    // In a real app, this would update the backend
    // For now, we'll just update the local state
    final updatedRestaurants = state.restaurants.map((restaurant) {
      if (restaurant.id == event.restaurantId) {
        // Toggle favorite status (you might want to add a favorite field to Restaurant model)
        return restaurant;
      }
      return restaurant;
    }).toList();

    emit(state.copyWith(restaurants: updatedRestaurants));
  }

  void _onLoadFoodCategories(
      LoadFoodCategories event, Emitter<FoodState> emit) {
    final categories = FoodCategory.sampleCategories;
    emit(state.copyWith(categories: categories));
  }

  void _onClearFilters(ClearFoodFilters event, Emitter<FoodState> emit) {
    emit(state.copyWith(
      filteredRestaurants: state.restaurants,
      selectedCategory: null,
      searchQuery: '',
    ));
  }
}
