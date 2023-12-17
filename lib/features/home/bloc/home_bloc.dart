import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shopping_app_usingbloc/data/cart_items.dart';
import 'package:shopping_app_usingbloc/data/clothing_options.dart';
import 'package:shopping_app_usingbloc/data/wishlist_items.dart';

import '../models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeInitial()){
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(homeProductWishlistbuttonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartbuttonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{

    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(products: ClothingOptions.clothingProducts.map((e) => ProductDataModel(
        id: e['id'],
        name: e['name'],
        description: e['description'],
        price: e['price'],
        imageUrl: e['imageUrl'])).toList()));
  }
  FutureOr<void> homeProductWishlistbuttonClickedEvent(
      HomeProductWishlistButtonClickedEvent event,Emitter<HomeState> emit){
    print("Wishlist Product Clicked");
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }
  FutureOr<void> homeProductCartbuttonClickedEvent(
      HomeProductCartButtonClickedEvent event,Emitter<HomeState> emit){
    print("Cart Product Clicked");
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }
  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart Clicked");
    emit(HomeNavigateToCartPageActionState());
  }
  FutureOr<void> homeWishlistButtonNavigateEvent(HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Wishlist Clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }


}