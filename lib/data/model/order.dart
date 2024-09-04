import 'dart:convert';

class Order {
  ShippingAddress shippingAddress;
  String? id;
  List<OrderItem> orderItems;
  String paymentMethod;
  int itemsPrice;
  int totalPrice;
  int shippingPrice;
  String user;
  bool isPaid;
  bool isDelivered;

  Order({
    required this.shippingAddress,
    this.id,
    required this.orderItems,
    required this.paymentMethod,
    required this.itemsPrice,
    required this.shippingPrice,
    required this.totalPrice,
    required this.user,
    required this.isPaid,
    required this.isDelivered,
  });

  Map<String, dynamic> toMap() {
    return {
      'shippingAddress': shippingAddress.toMap(),
      'id': id,
      'orderItems': orderItems.map((x) => x.toMap()).toList(),
      'paymentMethod': paymentMethod,
      'itemsPrice': itemsPrice,
      'totalPrice': totalPrice,
      'shippingPrice': shippingPrice,
      'user': user,
      'isPaid': isPaid,
      'isDelivered': isDelivered,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      shippingAddress: ShippingAddress.fromMap(
          map['shippingAddress'] as Map<String, dynamic>),
      id: map['id'] as String?,
      orderItems: List<OrderItem>.from(
        (map['orderItems'] as List<dynamic>? ?? []).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      paymentMethod: map['paymentMethod'] as String? ?? '',
      itemsPrice: map['itemsPrice'] as int? ?? 0,
      totalPrice: map['totalPrice'] as int? ?? 0,
      shippingPrice: map['shippingPrice'] as int? ?? 0,
      user: map['user'] as String? ?? '',
      isPaid: map['isPaid'] as bool? ?? false,
      isDelivered: map['isDelivered'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderItem {
  String name;
  int amount;
  String price;
  String image;
  int discount;
  String product;
  String id;

  OrderItem({
    required this.name,
    required this.amount,
    required this.price,
    required this.image,
    required this.discount,
    required this.product,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'price': price,
      'image': image,
      'discount': discount,
      'product': product,
      'id': id,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      name: map['name'] as String? ?? '',
      amount: map['amount'] as int? ?? 0,
      price: map['price'] as String? ?? '',
      image: map['image'] as String? ?? '',
      discount: map['discount'] as int? ?? 0,
      product: map['product'] as String? ?? '',
      id: map['id'] as String? ?? '',
    );
  }
}

class ShippingAddress {
  String fullName;
  String address;
  String city;
  int phone;

  ShippingAddress({
    required this.fullName,
    required this.address,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'address': address,
      'city': city,
      'phone': phone,
    };
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      fullName: map['fullName'] as String? ?? '',
      address: map['address'] as String? ?? '',
      city: map['city'] as String? ?? '',
      phone: map['phone'] as int? ?? 0,
    );
  }
}
