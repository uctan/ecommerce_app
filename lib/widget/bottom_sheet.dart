import 'package:app_ecomerce/data/model/product_api.dart';
import 'package:app_ecomerce/data/service/product_service.dart';
import 'package:app_ecomerce/widget/neumic_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

showCustomModalBottomSheet({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return FilterBottomSheet();
    },
  );
}

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int _selectedPriceIndex = -1; // Trạng thái chọn cho giá
  int _selectedCategoryIndex = -1; // Trạng thái chọn cho danh mục
  List<Product> _product = [];
  final ProductService _productService = ProductService();

  Future<void> _fetchProducts() async {
    _productService.setUpdateListener(() {
      setState(() {
        _product = _productService.products;
      });
    });
    await _productService.getAllProduct();
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final types = _product
        .map((_product) => _product.type)
        .where((type) => type != null)
        .toSet()
        .toList();

    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Price:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPriceFilterOption(
                index: 0,
                text: 'Giá từ cao đến thấp',
              ),
              _buildPriceFilterOption(
                index: 1,
                text: 'Giá từ thấp đến cao',
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Category:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  types.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildCategoryFilterOption(
                      index: index,
                      text: types[index]!,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Rating:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          NeumicSlider(),
        ],
      ),
    );
  }

  Widget _buildPriceFilterOption({required int index, required String text}) {
    bool isSelected = _selectedPriceIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPriceIndex = index;
        });
      },
      child: Container(
        width: 140,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilterOption(
      {required int index, required String text}) {
    bool isSelected = _selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        width: 140,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
