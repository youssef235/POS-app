/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_client_final/Client/Cubit/product_cubit.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductClientCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            productCubit.clearSearch();
          } else {
            productCubit.searchProducts(value);
          }
        },
      ),
    );
  }
}
 */