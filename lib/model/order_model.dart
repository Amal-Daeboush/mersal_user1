class OrderModel {
  final int id;
   int quantity;
  final String name;
  final String desc;
  final String image;
  final double price;
  final bool isAvailable;
  OrderModel( {required this.id,
    required this.quantity,
    required this.name,
    required this.desc,
    required this.price,
    required this.isAvailable,
    required this.image,
  });
}
