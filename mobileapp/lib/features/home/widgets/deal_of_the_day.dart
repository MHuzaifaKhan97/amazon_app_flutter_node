import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Deal of the day",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.topLeft,
            child: const Text(
              "\$1200",
              style: TextStyle(fontSize: 18),
            )),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            "Macbook Pro",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                  "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
              Image.network(
                  "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
              Image.network(
                  "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
              Image.network(
                  "https://cdn.shopify.com/s/files/1/1706/9177/products/macbook-air-gallery3-20201110.jpg?v=1613635025",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          child: Text(
            "See all deals",
            style: const TextStyle(
              color: Colors.cyan,
            ),
          ),
        )
      ],
    );
  }
}
