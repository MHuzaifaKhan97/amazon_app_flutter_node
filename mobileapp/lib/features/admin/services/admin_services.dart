import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/constants/error_handling.dart';
import 'package:mobileapp/constants/global_variables.dart';
import 'package:mobileapp/constants/utils.dart';
import 'package:mobileapp/features/admin/models/sales.dart';
import 'package:mobileapp/models/order.dart';
import 'package:mobileapp/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminServices {
  // Add Product
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary = CloudinaryPublic("dlpohahad", "bxpc5t0v");
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response response = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Fetch all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token,
        },
      );
      print(res);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  //Delete product

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token,
        },
        body: jsonEncode({
          "id": product.id,
        }),
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Fetch all orders
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-orders"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                Order.fromJson(jsonEncode(jsonDecode(res.body)[i])),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  // Change order status
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/admin/change-order-status"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token,
        },
        body: jsonEncode({
          "id": order.id,
          "status": status,
        }),
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get Analytics
  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/analytics"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales("Mobiles", response["mobileEarnings"]),
              Sales("Essentials", response["essentialEarnings"]),
              Sales("Appliances", response["applianceEarnings"]),
              Sales("Books", response["bookEarnings"]),
              Sales("Fashion", response["fashionEarnings"]),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
