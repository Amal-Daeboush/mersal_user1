// To parse this JSON data, do
//
//     final productsModelModel = productsModelModelFromJson(jsonString);

import 'dart:convert';

ProductsModelModel productsModelModelFromJson(String str) =>
    ProductsModelModel.fromJson(json.decode(str));

String productsModelModelToJson(ProductsModelModel data) =>
    json.encode(data.toJson());

class ProductsModelModel {
  final List<ProductModel> data;
  final int currentPage;
  final int perPage;
  final int total;
  final int lastPage;

  ProductsModelModel({
    required this.data,
    required this.currentPage,
    required this.perPage,
    required this.total,
  }) : lastPage = ((total + perPage - 1) / perPage).floor();

  factory ProductsModelModel.fromJson(Map<String, dynamic> json) {
    final total = json["total"] ?? 0;
    final perPage = json["per_page"] ?? 10;

    return ProductsModelModel(
      data:
          json["data"] != null
              ? List<ProductModel>.from(
                json["data"].map((x) => ProductModel.fromJson(x)),
              )
              : [],
      currentPage: json["current_page"] ?? 1,
      perPage: perPage,
      total: total,
    );
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
  };
}

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final dynamic categoryId;
  final String providerableType;
  final dynamic providerableId;
  final dynamic quantity;
  final String? timeOfService;
  final String? foodType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Image> images;
  final List<dynamic> rating;
  final DiscountInfo discountInfo;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.providerableType,
    required this.providerableId,
    required this.quantity,
    required this.timeOfService,
    required this.foodType,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.rating,
    required this.discountInfo,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    categoryId: json["category_id"],
    providerableType: json["providerable_type"],
    providerableId: json["providerable_id"],
    quantity: json["quantity"],
    timeOfService: json["time_of_service"],
    foodType: json["food_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    rating: List<dynamic>.from(json["rating"].map((x) => x)),
    discountInfo: DiscountInfo.fromJson(json["discount_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category_id": categoryId,
    "providerable_type": providerableType,
    "providerable_id": providerableId,
    "quantity": quantity,
    "food_type": foodType,
    "time_of_service": timeOfService,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "rating": List<dynamic>.from(rating.map((x) => x)),
    "discount_info": discountInfo.toJson(),
  };
}

class DiscountInfo {
  final bool hasDiscount;
  final String originalPrice;
  final dynamic finalPrice;
  final String? discountValue;
  final dynamic discountType;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;

  DiscountInfo({
    required this.hasDiscount,
    required this.originalPrice,
    required this.finalPrice,
    this.discountValue,
    this.discountType,
    this.discountStartDate,
    this.discountEndDate,
  });

  factory DiscountInfo.fromJson(Map<String, dynamic> json) => DiscountInfo(
    hasDiscount: json["has_discount"],
    originalPrice: json["original_price"],
    finalPrice: json["final_price"],
    discountValue: json["discount_value"],
    discountType: json["discount_type"],
    discountStartDate:
        json["discount_start_date"] == null
            ? null
            : DateTime.parse(json["discount_start_date"]),
    discountEndDate:
        json["discount_end_date"] == null
            ? null
            : DateTime.parse(json["discount_end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "has_discount": hasDiscount,
    "original_price": originalPrice,
    "final_price": finalPrice,
    "discount_value": discountValue,
    "discount_type": discountType,
    "discount_start_date": discountStartDate?.toIso8601String(),
    "discount_end_date": discountEndDate?.toIso8601String(),
  };
}

class Image {
  final String url;

  Image({required this.url});

  factory Image.fromJson(Map<String, dynamic> json) => Image(url: json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}
