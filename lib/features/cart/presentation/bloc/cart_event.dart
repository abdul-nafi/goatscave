part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartItemAdded extends CartEvent {
  final CartItem item;

  const CartItemAdded(this.item);

  @override
  List<Object> get props => [item];
}

class CartItemRemoved extends CartEvent {
  final String itemId;

  const CartItemRemoved(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class CartItemQuantityUpdated extends CartEvent {
  final String itemId;
  final int newQuantity;

  const CartItemQuantityUpdated(this.itemId, this.newQuantity);

  @override
  List<Object> get props => [itemId, newQuantity];
}

class CartCleared extends CartEvent {}

class CartRestaurantChanged extends CartEvent {
  final String restaurantId;

  const CartRestaurantChanged(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}
