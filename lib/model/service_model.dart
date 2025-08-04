import 'package:mersal/model/category_model.dart';

class ServiceModel {
  final String name;
  final String image;
  final double price;
  final String desc;
  final double rating;
  final CategoryModel category;

  ServiceModel({required this.name, required this.image, required this.price, required this.desc, required this.rating, required this.category});


}
