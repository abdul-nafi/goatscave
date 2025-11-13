part of 'cart_bloc.dart';

@immutable
class CartState extends Equatable {
  final Cart cart;
  final String? currentRestaurantId;
  final CartStatus status;

  const CartState({
    required this.cart,
    this.currentRestaurantId,
    this.status = CartStatus.initial,
  });

  double get totalAmount => cart.totalAmount;
  int get totalItems => cart.totalItems;
  bool get isEmpty => cart.items.isEmpty;
  bool get hasItems => cart.items.isNotEmpty;

  @override
  List<Object?> get props => [cart, currentRestaurantId, status];

  CartState copyWith({
    Cart? cart,
    String? currentRestaurantId,
    CartStatus? status,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      currentRestaurantId: currentRestaurantId ?? this.currentRestaurantId,
      status: status ?? this.status,
    );
  }
}

enum CartStatus {
  initial,
  loading,
  success,
  failure,
  restaurantConflict,
}
