part of 'grocery_bloc.dart';

enum GroceryStatus {
  initial,
  loading,
  success,
  error,
  storeDetailLoading,
  storeDetailSuccess,
  searching,
}

class GroceryState extends Equatable {
  final List<GroceryStore> stores;
  final List<GroceryStore> filteredStores;
  final GroceryStore? selectedStore;
  final List<GroceryCategory> categories;
  final String? selectedCategory;
  final String searchQuery;
  final GroceryStatus status;
  final String? errorMessage;
  final List<GroceryItem> storeItems;
  final List<GroceryItem> filteredItems;
  final String? selectedItemCategory;
  final String itemSearchQuery;
  final Map<String, int> cartQuantities;
  final List<dynamic> searchResults;
  final Map<String, List<GroceryItem>> storeItemsMap;
  final bool isSearching;
  final DateTime? selectedDeliverySlot;

  const GroceryState({
    this.stores = const [],
    this.filteredStores = const [],
    this.selectedStore,
    this.categories = const [],
    this.selectedCategory,
    this.searchQuery = '',
    this.status = GroceryStatus.initial,
    this.errorMessage,
    this.storeItems = const [],
    this.filteredItems = const [],
    this.selectedItemCategory,
    this.itemSearchQuery = '',
    this.cartQuantities = const {},
    this.searchResults = const [],
    this.storeItemsMap = const {},
    this.isSearching = false,
    this.selectedDeliverySlot,
  });

  bool get isLoading => status == GroceryStatus.loading;
  bool get hasError => status == GroceryStatus.error;
  bool get hasStores => filteredStores.isNotEmpty;
  bool get hasStoreItems => filteredItems.isNotEmpty;
  bool get hasSearchResults => searchResults.isNotEmpty;

  int get cartItemCount =>
      cartQuantities.values.fold(0, (sum, quantity) => sum + quantity);

  double get cartTotalAmount {
    return storeItems.fold(0.0, (total, item) {
      final quantity = cartQuantities[item.id] ?? 0;
      return total + (item.finalPrice * quantity);
    });
  }

  @override
  List<Object?> get props => [
        stores,
        filteredStores,
        selectedStore,
        categories,
        selectedCategory,
        searchQuery,
        status,
        errorMessage,
        storeItems,
        filteredItems,
        selectedItemCategory,
        itemSearchQuery,
        cartQuantities,
        searchResults,
        storeItemsMap,
        isSearching,
        selectedDeliverySlot,
      ];

  GroceryState copyWith({
    List<GroceryStore>? stores,
    List<GroceryStore>? filteredStores,
    GroceryStore? selectedStore,
    List<GroceryCategory>? categories,
    String? selectedCategory,
    String? searchQuery,
    GroceryStatus? status,
    String? errorMessage,
    List<GroceryItem>? storeItems,
    List<GroceryItem>? filteredItems,
    String? selectedItemCategory,
    String? itemSearchQuery,
    Map<String, int>? cartQuantities,
    List<dynamic>? searchResults,
    Map<String, List<GroceryItem>>? storeItemsMap,
    bool? isSearching,
    DateTime? selectedDeliverySlot,
  }) {
    return GroceryState(
      stores: stores ?? this.stores,
      filteredStores: filteredStores ?? this.filteredStores,
      selectedStore: selectedStore ?? this.selectedStore,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      storeItems: storeItems ?? this.storeItems,
      filteredItems: filteredItems ?? this.filteredItems,
      selectedItemCategory: selectedItemCategory ?? this.selectedItemCategory,
      itemSearchQuery: itemSearchQuery ?? this.itemSearchQuery,
      cartQuantities: cartQuantities ?? this.cartQuantities,
      searchResults: searchResults ?? this.searchResults,
      storeItemsMap: storeItemsMap ?? this.storeItemsMap,
      isSearching: isSearching ?? this.isSearching,
      selectedDeliverySlot: selectedDeliverySlot ?? this.selectedDeliverySlot,
    );
  }
}
