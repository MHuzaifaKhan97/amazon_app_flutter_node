import 'package:flutter/material.dart';
import 'package:mobileapp/constants/global_variables.dart';
import 'package:mobileapp/features/account/widgets/single_product.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // temporary list
  List list = [
    "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
    "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
    "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
    // {
    //   'image':
    // }
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        // Order list
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return SingleProduct(image: list[index]);
              }),
        ),
      ],
    );
  }
}
