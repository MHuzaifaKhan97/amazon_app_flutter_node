import 'package:flutter/material.dart';
import 'package:mobileapp/constants/global_variables.dart';
import 'package:mobileapp/features/home/screens/categories_deal_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoriesDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: GlobalVariables.categoryImages.length,
            itemExtent: 75,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  navigateToCategoryPage(
                      context, GlobalVariables.categoryImages[index]["title"]!);
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          GlobalVariables.categoryImages[index]["image"]!,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      GlobalVariables.categoryImages[index]["title"]!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
