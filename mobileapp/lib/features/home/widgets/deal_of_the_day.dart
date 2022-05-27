import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/loader.dart';
import 'package:mobileapp/features/home/services/home_services.dart';
import 'package:mobileapp/features/product_details/screens/product_details_screen.dart';
import 'package:mobileapp/models/product.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  HomeService homeService = HomeService();
  Product? product;
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeService.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                      arguments: product);
                },
                child: Column(
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
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "\$${product!.price}",
                          style: const TextStyle(fontSize: 18),
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map((e) => Image.network(e,
                                fit: BoxFit.fitWidth, width: 100, height: 100))
                            .toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      child: const Text(
                        "See all deals",
                        style: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}
