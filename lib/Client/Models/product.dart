class Product {
  final String id;
  final String name;
  final double price;
  final String type;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      type: json['type'],
      imageUrl: json['imageUrl'],
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 0});
}
