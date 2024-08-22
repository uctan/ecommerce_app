import 'dart:convert';
import 'dart:typed_data';

import 'package:app_ecomerce/common/app_state_cubit/app_state_cubit.dart';
import 'package:app_ecomerce/data/model/cart_item.dart';
import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ShopListItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final int index;

  const ShopListItemWidget(
      {super.key, required this.cartItem, required this.index});

  @override
  State<ShopListItemWidget> createState() => _ShopListItemWidgetState();
}

class _ShopListItemWidgetState extends State<ShopListItemWidget> {
  Product product = Product();
  @override
  Widget build(BuildContext context) {
    String base64String = widget.cartItem.product.image ?? '';
    Uint8List decodedBytes = base64Decode(base64String.split(',')[1]);
    final priceFormatted = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
        .format(widget.cartItem.product.price);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Slidable(
        key: Key(widget.cartItem.product.id ?? ''),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    text: 'Do you want to delete this product?',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    confirmBtnColor: Colors.blue,
                    onConfirmBtnTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .removeCartItem(widget.index);
                      Navigator.of(context).pop();
                    });
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]),
          child: Row(
            children: [
              Container(
                child: buildImage(decodedBytes: decodedBytes),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.product.name!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Quantity: ${widget.cartItem.product.countInStock!}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '${widget.cartItem.product.discount!}%',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          priceFormatted,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            buildOutlineButton(
                              icon: Icons.remove,
                              press: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .decreaseCartItemQuantity(widget.index);
                              },
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${widget.cartItem.quantity.toString()}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            buildOutlineButton(
                              icon: Icons.add,
                              press: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .increaseCartItemQuantity(widget.index);
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

  SizedBox buildOutlineButton(
      {required IconData icon, required VoidCallback press}) {
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
        onPressed: press,
      ),
    );
  }
}
