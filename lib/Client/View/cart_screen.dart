import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_client_final/Client/Cubit/product_cubit.dart';
import 'package:pos_client_final/Client/Cubit/product_state.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ProductClientCubit>().loadCart();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: BlocBuilder<ProductClientCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            if (state.cart.isEmpty) {
              return const Center(
                  child: Text('No items in the cart',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final item = state.cart[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Row(
                      children: [
                        // إضافة صورة من الشبكة
                        ClipOval(
                          child: Image.network(
                            item.product.imageUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          item.product.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      'Quantity: ${item.quantity}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      '\$${item.product.price * item.quantity}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(
                child: Text('Error: ${state.message}',
                    style: TextStyle(color: Colors.red)));
          } else {
            return Center(
                child: Text('No items in the cart',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductClientCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
            double totalPrice = state.cart.fold(
              0,
              (sum, item) => sum + item.product.price * item.quantity,
            );

            return Container(
              color: Colors.blueGrey[100],
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Implement checkout functionality here
                    },
                    child: Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  OutlinedButton(
                    onPressed: () {
                      // Implement clear cart functionality here
                    },
                    child: Text('Clear Cart'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
