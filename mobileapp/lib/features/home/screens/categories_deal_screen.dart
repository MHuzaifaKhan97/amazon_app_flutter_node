import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/loader.dart';
import 'package:mobileapp/constants/global_variables.dart';
import 'package:mobileapp/features/home/services/home_services.dart';
import 'package:mobileapp/features/product_details/screens/product_details_screen.dart';
import 'package:mobileapp/models/product.dart';

class CategoriesDealsScreen extends StatefulWidget {
  static const String routeName = "/category-deals";
  final String category;
  const CategoriesDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoriesDealsScreen> createState() => _CategoriesDealsScreenState();
}

class _CategoriesDealsScreenState extends State<CategoriesDealsScreen> {
  HomeService homeService = HomeService();
  List<Product>? productList;

  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  void fetchCategoryProduct() async {
    productList = await homeService.fetchCategoriesProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient)),
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.black),
            )),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep shopping for ${widget.category}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: productList!.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailsScreen.routeName,
                                arguments: product);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      product.images[0],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 15),
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
