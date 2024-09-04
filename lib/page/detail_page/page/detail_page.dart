import 'dart:convert';
import 'dart:typed_data';
import 'package:app_ecomerce/common/config/constants.dart';
import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/model/user_api.dart';
import 'package:app_ecomerce/data/provider/cart_provider.dart';
import 'package:app_ecomerce/data/service/product_service.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:app_ecomerce/page/detail_page/widget/cart_item_badge.dart';
import 'package:app_ecomerce/page/quick_food/widget/product_card.dart';
import 'package:app_ecomerce/page/shopping_cart/page/shopping_cart_page.dart';
import 'package:app_ecomerce/widget/shimmer_loading.dart';
import 'package:app_ecomerce/widget/shimmer_loading_category.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.productID});
  final String productID;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool isLoading = true;
  Product product = Product();
  User _user = User();
  final UserService _userService = UserService();

  int _cartItemsNo = 0;
  @override
  void initState() {
    super.initState();
    _fetchProductDetail();
    _fetchProducts();
    _fetchCurrentUser();
  }

  void _updateCartItemNo() {
    setState(() {
      _cartItemsNo = context.read<CartProvider>().cartItems.length;
    });
  }

  Future<void> _fetchProductDetail() async {
    _productService.setUpdateListener(() {
      setState(() {
        if (_productService.products.isNotEmpty) {
          product = _productService.products.firstWhere(
              (p) => p.id == widget.productID,
              orElse: () => Product());
          isLoading = false;
        }
      });
    });
    await _productService.getDetailProduct(widget.productID);
  }

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

  Future<void> _fetchProducts() async {
    await _productService.getAllProduct();

    setState(() {
      _products = _productService.products;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String base64String = product.image ?? '';
    Uint8List? decodedBytes;

    if (base64String.isNotEmpty) {
      try {
        decodedBytes = base64Decode(base64String.split(',').last);
      } catch (e) {
        decodedBytes = null;
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            if (decodedBytes != null)
              SizedBox(
                width: double.infinity,
                child: Image.memory(
                  decodedBytes,
                  fit: BoxFit.cover,
                ),
              )
            else
              Positioned.fill(
                child: ShimmerLoading(),
              ),
            buttonArrow(context),
            scroll(),
          ],
        ),
      ),
    );
  }

  Widget buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.3),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(),
                  ));
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.3),
              ),
              child: CartItemBadge(
                cartItemsNo: _cartItemsNo,
                badgeColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget scroll() {
    final priceFormatted = product.price != null
        ? NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
            .format(product.price)
        : 'Loading...';

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isLoading
                          ? ShimmerLoadingMin()
                          : Text(
                              product.name ?? 'No Name',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.star1,
                            color: Colors.yellow,
                            size: 30,
                          ),
                          // Text('${product.rating ?? 0}/5')
                          isLoading
                              ? ShimmerLoadingMin()
                              : Text(
                                  '${product.rating}/5' ?? '0',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? ShimmerLoadingMin()
                      : Text(
                          'Quantity : ${product.countInStock ?? '0'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          isLoading
                              ? ShimmerLoadingMin()
                              : Text(
                                  priceFormatted,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                          SizedBox(width: 10),
                          isLoading
                              ? ShimmerLoadingMin()
                              : Text(
                                  "${product.discount ?? 0}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        child: isLoading
                            ? ShimmerLoadingMin()
                            : Text('Selled : ${product.selled ?? 0}'),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(height: 4),
                  const SizedBox(height: 10),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    child: isLoading
                        ? ShimmerLoadingMin()
                        : Text(
                            product.description ?? 'No description available',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          // border: Border.all(
                          //   color: kprimaryColor,
                          // ),
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Iconsax.device_message,
                                color: kprimaryColor,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              // int countInStock =
                              //     (product.countInStock ?? 0).toInt();
                              // if (cartQuantity > countInStock) {
                              //   QuickAlert.show(
                              //     context: context,
                              //     type: QuickAlertType.error,
                              //     title: 'Oops...',
                              //     text:
                              //         'The product you added exceeds the quantity in stock.',
                              //   );
                              // } else {

                              // }
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Product has been added to cart!',
                                confirmBtnText: 'Ok',
                              );
                              // context.read<AppStateCubit>().addProductToCart(
                              //       product,
                              _updateCartItemNo();
                              context.read<CartProvider>().addToCart(
                                    product,
                                    1,
                                    'Default',
                                    _user.id ?? '',
                                  );
                            },
                            child: Text(
                              'Add to cart'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    height: 0.1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Recommendations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        if (isLoading) {
                          return ProductCard(
                            product: Product(),
                            isLoading: true,
                          );
                        } else if (index < _products.length) {
                          return ProductCard(
                            product: _products[index],
                            isLoading: false,
                          );
                        }
                      },
                      itemCount: isLoading
                          ? 4
                          : (_products.length > 4 ? 4 : _products.length),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
