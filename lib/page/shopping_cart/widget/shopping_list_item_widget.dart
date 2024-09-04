import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/model/user_api.dart';

import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShopListItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final int index;

  const ShopListItemWidget({
    super.key,
    required this.cartItem,
    required this.index,
  });

  @override
  State<ShopListItemWidget> createState() => _ShopListItemWidgetState();
}

class _ShopListItemWidgetState extends State<ShopListItemWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCurrentUser();
  }

  User _user = User();
  final UserService _userService = UserService();
  Future<void> _fetchCurrentUser() async {
    _userService.setUpdateListerner(() {
      setState(() {
        if (_userService.users.isNotEmpty) {
          _user = _userService.users.first;
        }
      });
    });
    _userService.fetchUserCurrent();
  }

  @override
  Widget build(BuildContext context) {
    final String base64String = widget.cartItem.product.image ?? '';
    final Uint8List decodedBytes = base64Decode(base64String.split(',').last);
    final String priceFormatted = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'VNĐ',
    ).format(widget.cartItem.product.price);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Slidable(
        key: Key(widget.cartItem.product.id ?? ''),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Provider.of<CartProvider>(context, listen: false)
                    .removeCartItem(
                  widget.index,
                  _user.id ?? '',
                );
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              buildImage(decodedBytes: decodedBytes),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.product.name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Quantity: ${widget.cartItem.product.countInStock!}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '${widget.cartItem.product.discount!}%',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          priceFormatted,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            buildOutlineButton(
                              icon: Icons.remove,
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .decreaseCartItemQuantity(
                                  widget.index,
                                  _user.id ?? '',
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${widget.cartItem.quantity}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            buildOutlineButton(
                              icon: Icons.add,
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .increaseCartItemQuantity(
                                  widget.index,
                                  _user.id ?? '',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage({required Uint8List decodedBytes}) {
    return SizedBox(
      height: 100,
      child: Image.memory(
        decodedBytes,
        fit: BoxFit.fill,
      ),
    );
  }

  SizedBox buildOutlineButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: OutlinedButton(
        child: Icon(icon),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
