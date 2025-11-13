import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goatscave/features/cart/data/data.dart';
import 'package:flutter/foundation.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(cart: Cart(items: []))) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartItemQuantityUpdated>(_onQuantityUpdated);
    on<CartCleared>(_onCleared);
    on<CartRestaurantChanged>(_onRestaurantChanged);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    try {
      // Check if adding item from different restaurant
      if (state.currentRestaurantId != null &&
          event.item.restaurantId != null &&
          event.item.restaurantId != state.currentRestaurantId) {
        emit(state.copyWith(status: CartStatus.restaurantConflict));
        return;
      }

      final newCart = state.cart.addItem(event.item);
      final restaurantId = event.item.restaurantId ?? state.currentRestaurantId;

      emit(state.copyWith(
        cart: newCart,
        currentRestaurantId: restaurantId,
        status: CartStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.failure));
    }
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    try {
      final newCart = state.cart.removeItem(event.itemId);

      // Clear restaurant if cart is empty
      final restaurantId =
          newCart.items.isEmpty ? null : state.currentRestaurantId;

      emit(state.copyWith(
        cart: newCart,
        currentRestaurantId: restaurantId,
        status: CartStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.failure));
    }
  }

  void _onQuantityUpdated(
      CartItemQuantityUpdated event, Emitter<CartState> emit) {
    try {
      final newCart =
          state.cart.updateQuantity(event.itemId, event.newQuantity);
      emit(state.copyWith(cart: newCart, status: CartStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.failure));
    }
  }

  void _onCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState(cart: Cart(items: []), currentRestaurantId: null));
  }

  void _onRestaurantChanged(
      CartRestaurantChanged event, Emitter<CartState> emit) {
    emit(state.copyWith(currentRestaurantId: event.restaurantId));
  }

  // Helper methods
  bool canAddItemFromRestaurant(String restaurantId) {
    return state.currentRestaurantId == null ||
        state.currentRestaurantId == restaurantId;
  }

  int getItemQuantity(String itemId) {
    try {
      final item = state.cart.items.firstWhere(
        (item) => item.id == itemId,
      );
      return item.quantity;
    } catch (e) {
      return 0;
    }
  }
}
