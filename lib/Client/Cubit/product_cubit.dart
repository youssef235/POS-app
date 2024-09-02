import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos_client_final/Client/Cubit/auth_cubit.dart';
import 'package:pos_client_final/Client/Cubit/auth_state.dart';
import 'package:pos_client_final/Client/Cubit/product_state.dart';
import 'package:pos_client_final/Client/Models/product.dart';

class ProductClientCubit extends Cubit<ProductState> {
  final FirebaseFirestore firestore;
  final AuthCubit authCubit;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  ProductClientCubit(this.firestore, this.authCubit) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final snapshot = await firestore.collection('products').get();
      _allProducts = snapshot.docs.map((doc) {
        return Product.fromJson(
            {...doc.data() as Map<String, dynamic>, 'id': doc.id});
      }).toList();
      _filteredProducts = _allProducts;
      emit(ProductLoaded(products: _filteredProducts));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void searchProducts(String query) {
    final filteredProducts = _allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    _filteredProducts = filteredProducts;
    emit(ProductLoaded(products: _filteredProducts));
  }

  void addToCart(Product product) {
    final currentState = state;
    if (currentState is ProductLoaded) {
      final updatedCart = List<CartItem>.from(currentState.cart);
      final cartItem = updatedCart.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => CartItem(product: product),
      );
      cartItem.quantity++;
      updatedCart.removeWhere((item) => item.product.id == product.id);
      updatedCart.add(cartItem);

      emit(currentState.copyWith(cart: updatedCart));

      final userId = (authCubit.state as AuthAuthenticated).userId;
      firestore.collection('users').doc(userId).collection('cart').add(
        {
          'productId': product.id,
          'quantity': cartItem.quantity,
        },
      );
    }
  }

  Future<void> loadCart() async {
    final currentState = state;
    if (currentState is ProductLoaded) {
      try {
        final userId = (authCubit.state as AuthAuthenticated).userId;
        final snapshot = await firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .get();

        final cartItems = snapshot.docs.map((doc) {
          final data = doc.data();
          final product = _allProducts.firstWhere(
            (p) => p.id == data['productId'],
          );
          return CartItem(
            product: product,
            quantity: data['quantity'],
          );
        }).toList();

        emit(currentState.copyWith(cart: cartItems));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    }
  }
}
