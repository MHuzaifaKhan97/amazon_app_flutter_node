import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/custom_button.dart';
import 'package:mobileapp/common/widgets/custom_textfield.dart';
import 'package:mobileapp/constants/global_variables.dart';
import 'package:mobileapp/constants/utils.dart';
import 'package:mobileapp/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productdescController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productQuantityController =
      TextEditingController();
  final AdminServices adminServices = AdminServices();
  final _addProductFormKey = GlobalKey<FormState>();
  String category = "Mobiles";
  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];
  List<File> images = [];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: productdescController.text,
          price: double.parse(productPriceController.text),
          quantity: double.parse(productQuantityController.text),
          category: category,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productdescController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              flexibleSpace: Container(
                  decoration:
                      BoxDecoration(gradient: GlobalVariables.appBarGradient)),
              title: const Text(
                "Add Product",
                style: TextStyle(color: Colors.black),
              )),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    images.isNotEmpty
                        ? CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                            items: images.map((i) {
                              return Builder(builder: (context) {
                                return Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 300,
                                );
                              });
                            }).toList())
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 15),
                                      Text("Select Product Image",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade400))
                                    ]),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    CustomTextField(
                        controller: productNameController,
                        hintText: "Product Name"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        maxLines: 7,
                        controller: productdescController,
                        hintText: "Description"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: productPriceController, hintText: "Price"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: productQuantityController,
                        hintText: "Quantity"),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue!;
                            });
                          },
                          value: category,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: productCategories.map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList()),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: "Sell",
                        onTap: () {
                          sellProduct();
                        }),
                  ],
                ),
              )),
        ));
  }
}
