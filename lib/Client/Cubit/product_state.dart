import 'package:equatable/equatable.dart';
import 'package:pos_client_final/Client/Models/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<CartItem> cart;

  ProductLoaded({required this.products, this.cart = const []});

  ProductLoaded copyWith({List<Product>? products, List<CartItem>? cart}) {
    return ProductLoaded(
      products: products ?? this.products,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object> get props => [products, cart];
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
