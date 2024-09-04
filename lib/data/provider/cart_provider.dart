import 'dart:convert';

import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_api.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  CartProvider(String userId) {
    loadCart(userId);
  }
  List<CartItem> get cartItems => _cartItems;

  Future<void> saveCart(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartJson =
        jsonEncode(_cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cart_$userId', cartJson);
    notifyListeners();
  }

  Future<void> loadCart(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cart_$userId');
    if (cartJson != null) {
      List<dynamic> cartList = jsonDecode(cartJson);
      _cartItems.clear();
      _cartItems
          .addAll(cartList.map((item) => CartItem.fromJson(item)).toList());
      saveCart(userId);
      notifyListeners();
    }
  }

  void addToCart(
      Product product, int quantity, String selectedVariant, String userId) {
    print('User ID khi lưu giỏ hàng: $userId');
    var existingCartItem = _cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );

    if (existingCartItem != null) {
      existingCartItem.quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
    saveCart(userId);
    notifyListeners();
  }

  int getProductQuantity(int productId, String userId) {
    int quantity = 0;
    for (CartItem item in _cartItems) {
      if (item.product.id == productId) {
        quantity += item.quantity;
      }
    }
    saveCart(userId);
    return quantity;
  }

  int get cartCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return _cartItems.fold(
      0.0,
      (sum, item) =>
          sum +
          ((item.product.price! * item.quantity * (100 - totalDiscount) / 100)),
    );
  }

  double get totalDiscount {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item.product.discount ?? 0),
    );
  }

  void updateCartItemQuantity(int index, int newQuantity, String userId) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity = newQuantity;

      notifyListeners();
      saveCart(userId);
    }
  }

  void increaseCartItemQuantity(int index, String userId) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity++;
      print(
          'Tăng số lượng sản phẩm tại chỉ số $index cho user $userId. Số lượng mới: ${_cartItems[index].quantity}');
      saveCart(userId);
      updateCartItemQuantity(index, _cartItems[index].quantity, userId);
      notifyListeners();
    } else {
      print(
          'Chỉ số $index không hợp lệ khi tăng số lượng sản phẩm cho user $userId');
      updateCartItemQuantity(index, _cartItems[index].quantity, userId);
    }
  }

  void decreaseCartItemQuantity(int index, String userId) {
    if (index >= 0 && index < _cartItems.length) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
        print(
            'Giảm số lượng sản phẩm tại chỉ số $index cho user $userId. Số lượng mới: ${_cartItems[index].quantity}');
        saveCart(userId);
        updateCartItemQuantity(index, _cartItems[index].quantity, userId);
        notifyListeners();
      } else {
        print(
            'Số lượng sản phẩm tại chỉ số $index của user $userId đã đạt giá trị tối thiểu. Loại bỏ sản phẩm.');
        _cartItems.removeAt(index);
        saveCart(userId);
        updateCartItemQuantity(index, _cartItems[index].quantity, userId);
        notifyListeners();
      }
    } else {
      print(
          'Chỉ số $index không hợp lệ khi giảm số lượng sản phẩm cho user $userId');
    }
  }

  void removeCartItem(int index, String userId) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      saveCart(userId);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  List<CartItem> getCartItemsList() {
    return List<CartItem>.from(_cartItems);
  }
}
