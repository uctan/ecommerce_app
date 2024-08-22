import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/model/user_api.dart';
import 'package:app_ecomerce/data/service/product_service.dart';
import 'package:app_ecomerce/data/service/user_service.dart';
import 'package:app_ecomerce/page/home_page/widget/category.dart';
import 'package:app_ecomerce/page/home_page/widget/home_appbar.dart';
import 'package:app_ecomerce/page/home_page/widget/home_search_bar.dart';
import 'package:app_ecomerce/page/home_page/widget/quick_fastList.dart';
import 'package:app_ecomerce/page/quick_food/list_food_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentCat = "All";
  User _user = User();
  final UserService _userService = UserService();
  final ProductService _productService = ProductService();
  List<Product> _product = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUser();
    _userService.fetchUserCurrent();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    // try {
    //   await _productService.getAllProduct();
    //   _productService.setUpdateListener(() {
    //     setState(() {
    //       _product = _productService.products;
    //       isLoading = false;
    //     });
    //   });
    // } catch (error) {
    //   // Handle error
    //   print('Error fetching products: $error');
    // }
    await _productService.getAllProduct();

    setState(() {
      _product = _productService.products;
      isLoading = false;
    });
  }

  Future<void> _fetchUser() async {
    _userService.setUpdateListerner(() {
      setState(() {
        if (_userService.users.isNotEmpty) {
          _user = _userService.users.first;
        }
      });
    });
  }

  //lam anh chuyen dong
  final myitems = [
    Image.asset('assets/images/panner1.png'),
    Image.asset('assets/images/bannerIT.png'),
    Image.asset('assets/images/banner2.png'),
    Image.asset('assets/images/banner3.png'),
    Image.asset('assets/images/banner4.png'),
  ];
  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${_user.name}!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Find Your Best Technology Here!',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                HomeSearchBar(),
                const SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 200,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayInterval: Duration(seconds: 2),
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        myCurrentIndex = index;
                      });
                    },
                  ),
                  items: myitems,
                ),
                SizedBox(height: 10),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: myCurrentIndex,
                    count: myitems.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Event",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/taingheevent.png',
                      width: 190,
                      height: 190,
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/even2.png',
                          width: 160,
                          height: 100,
                        ),
                        Image.asset(
                          'assets/images/event3.png',
                          width: 160,
                          height: 100,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Category(
                  currentCat: currentCat,
                  product: _product,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Most Popular',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListFoodPage())),
                      child: Text("View all"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                QuickAndFastList(
                  products: _product,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
