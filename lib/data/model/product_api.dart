import 'dart:convert';

class Product {
  String? id;
  String? name;
  int? price;
  String? type;
  double? countInStock;
  int? rating;
  String? discount;
  int? selled;
  String? image;
  String? description;
  Product({
    this.id,
    this.name,
    this.price,
    this.type,
    this.countInStock,
    this.rating,
    this.discount,
    this.selled,
    this.image,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'countInStock': countInStock,
      'rating': rating,
      'discount': discount,
      'selled': selled,
      'image': image,
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      countInStock: map['countInStock'] != null
          ? (map['countInStock'] is int
              ? (map['countInStock'] as int).toDouble()
              : map['countInStock'] as double)
          : null,
      rating: map['rating'] != null ? map['rating'] as int : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      selled: map['selled'] != null ? map['selled'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, type: $type, countInStock: $countInStock, rating: $rating, discount: $discount, selled: $selled, image: $image, description: $description)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.type == type &&
        other.countInStock == countInStock &&
        other.rating == rating &&
        other.discount == discount &&
        other.selled == selled &&
        other.image == image &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        type.hashCode ^
        countInStock.hashCode ^
        rating.hashCode ^
        discount.hashCode ^
        selled.hashCode ^
        image.hashCode ^
        description.hashCode;
  }
}
