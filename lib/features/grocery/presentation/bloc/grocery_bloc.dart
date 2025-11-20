import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goatscave/features/grocery/grocery.dart';

part 'grocery_event.dart';
part 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  GroceryBloc() : super(const GroceryState()) {
    on<LoadGroceryStores>(_onLoadGroceryStores);
    on<LoadGroceryStoreDetail>(_onLoadGroceryStoreDetail);
    on<SearchGroceryStores>(_onSearchGroceryStores);
    on<FilterStoresByCategory>(_onFilterStoresByCategory);
    on<LoadStoreItems>(_onLoadStoreItems);
    on<FilterItemsByCategory>(_onFilterItemsByCategory);
    on<SearchStoreItems>(_onSearchStoreItems);
    on<ClearItemFilters>(_onClearItemFilters);
    on<AddGroceryToCart>(_onAddGroceryToCart);
    on<UpdateGroceryCartQuantity>(_onUpdateGroceryCartQuantity);
    on<ClearGroceryCart>(_onClearGroceryCart);
    on<SelectDeliverySlot>(_onSelectDeliverySlot);
  }

  Future<void> _onLoadGroceryStores(
    LoadGroceryStores event,
    Emitter<GroceryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: GroceryStatus.loading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final stores = GroceryStore.sampleStores;
      final categories = GroceryCategory.sampleCategories;
      final allItems = GroceryItem.sampleItems;

      // Pre-load items for all stores for search functionality
      final storeItemsMap = <String, List<GroceryItem>>{};
      for (final store in stores) {
        final storeItems =
            allItems.where((item) => item.storeId == store.id).toList();
        storeItemsMap[store.id] = storeItems;
      }

      emit(state.copyWith(
        stores: stores,
        filteredStores: stores,
        categories: categories,
        storeItemsMap: storeItemsMap,
        status: GroceryStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryStatus.error,
        errorMessage: 'Failed to load grocery stores: ${e.toString()}',
      ));
    }
  }

  void _onLoadGroceryStoreDetail(
    LoadGroceryStoreDetail event,
    Emitter<GroceryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: GroceryStatus.storeDetailLoading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      final store = state.stores.firstWhere(
        (s) => s.id == event.storeId,
        orElse: () => GroceryStore.sampleStores.first,
      );

      emit(state.copyWith(
        selectedStore: store,
        status: GroceryStatus.storeDetailSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryStatus.error,
        errorMessage: 'Failed to load store details: ${e.toString()}',
      ));
    }
  }

  void _onSearchGroceryStores(
    SearchGroceryStores event,
    Emitter<GroceryState> emit,
  ) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        filteredStores: state.stores,
        searchQuery: '',
      ));
      return;
    }

    final filtered = state.stores.where((store) {
      return store.name.toLowerCase().contains(query) ||
          store.description.toLowerCase().contains(query) ||
          store.categories
              .any((category) => category.toLowerCase().contains(query));
    }).toList();

    emit(state.copyWith(
      filteredStores: filtered,
      searchQuery: query,
    ));
  }

  void _onFilterStoresByCategory(
    FilterStoresByCategory event,
    Emitter<GroceryState> emit,
  ) {
    if (event.category == state.selectedCategory) {
      // If same category clicked, clear filter
      emit(state.copyWith(
        filteredStores: state.stores,
        selectedCategory: null,
      ));
    } else {
      final filtered = state.stores.where((store) {
        return store.categories.contains(event.category);
      }).toList();

      emit(state.copyWith(
        filteredStores: filtered,
        selectedCategory: event.category,
      ));
    }
  }

  void _onLoadStoreItems(
    LoadStoreItems event,
    Emitter<GroceryState> emit,
  ) async {
    try {
      emit(state.copyWith(status: GroceryStatus.loading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Get items for specific store from cached items
      final items =
          state.storeItemsMap[event.storeId] ?? GroceryItem.sampleItems;

      emit(state.copyWith(
        storeItems: items,
        filteredItems: items,
        status: GroceryStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GroceryStatus.error,
        errorMessage: 'Failed to load store items: ${e.toString()}',
      ));
    }
  }

  void _onFilterItemsByCategory(
    FilterItemsByCategory event,
    Emitter<GroceryState> emit,
  ) {
    if (event.category == state.selectedItemCategory) {
      // Clear filter if same category clicked
      emit(state.copyWith(
        filteredItems: state.storeItems,
        selectedItemCategory: null,
      ));
    } else {
      final filtered = state.storeItems.where((item) {
        return item.category == event.category;
      }).toList();

      emit(state.copyWith(
        filteredItems: filtered,
        selectedItemCategory: event.category,
      ));
    }
  }

  void _onSearchStoreItems(
    SearchStoreItems event,
    Emitter<GroceryState> emit,
  ) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      // Apply category filter if active
      final filtered = state.selectedItemCategory != null
          ? state.storeItems
              .where((item) => item.category == state.selectedItemCategory)
              .toList()
          : state.storeItems;

      emit(state.copyWith(
        filteredItems: filtered,
        itemSearchQuery: '',
      ));
      return;
    }

    final filtered = state.storeItems.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query) ||
          item.brand.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(
      filteredItems: filtered,
      itemSearchQuery: query,
    ));
  }

  void _onClearItemFilters(
    ClearItemFilters event,
    Emitter<GroceryState> emit,
  ) {
    emit(state.copyWith(
      filteredItems: state.storeItems,
      selectedItemCategory: null,
      itemSearchQuery: '',
    ));
  }

  void _onAddGroceryToCart(
    AddGroceryToCart event,
    Emitter<GroceryState> emit,
  ) {
    final updatedQuantities = Map<String, int>.from(state.cartQuantities);
    updatedQuantities[event.itemId] =
        (updatedQuantities[event.itemId] ?? 0) + event.quantity;

    emit(state.copyWith(cartQuantities: updatedQuantities));
  }

  void _onUpdateGroceryCartQuantity(
    UpdateGroceryCartQuantity event,
    Emitter<GroceryState> emit,
  ) {
    final updatedQuantities = Map<String, int>.from(state.cartQuantities);

    if (event.quantity <= 0) {
      updatedQuantities.remove(event.itemId);
    } else {
      updatedQuantities[event.itemId] = event.quantity;
    }

    emit(state.copyWith(cartQuantities: updatedQuantities));
  }

  void _onClearGroceryCart(
    ClearGroceryCart event,
    Emitter<GroceryState> emit,
  ) {
    emit(state.copyWith(cartQuantities: {}));
  }

  void _onSelectDeliverySlot(
    SelectDeliverySlot event,
    Emitter<GroceryState> emit,
  ) {
    emit(state.copyWith(selectedDeliverySlot: event.slot));
  }

  // Helper methods
  void addToGroceryCart(String itemId, {int quantity = 1}) {
    add(AddGroceryToCart(itemId, quantity));
  }

  void updateGroceryCartQuantity(String itemId, int quantity) {
    add(UpdateGroceryCartQuantity(itemId, quantity));
  }

  void clearGroceryCart() {
    add(ClearGroceryCart());
  }

  void selectDeliverySlot(DateTime slot) {
    add(SelectDeliverySlot(slot));
  }
}
