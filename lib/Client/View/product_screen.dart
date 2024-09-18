import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_client_final/Client/Cubit/product_cubit.dart';
import 'package:pos_client_final/Client/Cubit/product_state.dart';
import 'package:pos_client_final/Client/Services/auth_services.dart';
import 'package:pos_client_final/Client/View/signin_screen.dart';
import 'package:pos_client_final/Client/widgets/product_card.dart';

class ProductsClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ProductClientCubit>().fetchProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[400],
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().saveUserLoggedInStatus(false);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                context.read<ProductClientCubit>().searchProducts(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductClientCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return ProductCard(
                        product: product,
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('No products available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
