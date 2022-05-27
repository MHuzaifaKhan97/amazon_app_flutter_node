import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/loader.dart';
import 'package:mobileapp/features/account/widgets/single_product.dart';
import 'package:mobileapp/features/admin/screens/add_product_screen.dart';
import 'package:mobileapp/features/admin/screens/admin_screen.dart';
import 'package:mobileapp/features/admin/services/admin_services.dart';
import 'package:mobileapp/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product>? products;
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        setState(() {
          products!.removeAt(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                  itemCount: products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 135,
                          child: SingleProduct(image: productData.images[0]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: Text(productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2)),
                            IconButton(
                                onPressed: () {
                                  deleteProduct(productData, index);
                                },
                                icon: const Icon(Icons.delete_outline))
                          ],
                        )
                      ],
                    );
                  }),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: "Add a product",
              child: const Icon(
                Icons.add,
              ),
              onPressed: navigateToAddProduct,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
