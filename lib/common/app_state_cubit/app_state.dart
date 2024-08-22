import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final List<Product> items;

  // Khởi tạo constructor
  AppState({required this.items});

  factory AppState.initial() {
    return AppState(items: []);
  }

  @override
  List<Object?> get props => [items];
}
