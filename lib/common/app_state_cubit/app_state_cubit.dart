import 'package:app_ecomerce/common/app_state_cubit/app_state.dart';
import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStateCubit extends Cubit<AppState> {
  AppStateCubit() : super(AppState.initial());


  List<Product> get items => state.items;

  void addProductToCart(Product product) {
    final updatedItems = List<Product>.from(state.items)..add(product);
    emit(AppState(items: updatedItems));
  }

  void deleteProductFromCart(Product product) {
    final updatedItems = List<Product>.from(state.items)
      ..removeWhere((item) => item.id == product.id);
    emit(AppState(items: updatedItems));
  }
}
