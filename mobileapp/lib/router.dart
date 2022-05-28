import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/bottom_bar.dart';
import 'package:mobileapp/features/address/screens/address_screen.dart';
import 'package:mobileapp/features/admin/screens/add_product_screen.dart';
import 'package:mobileapp/features/auth/screens/auth_screen.dart';
import 'package:mobileapp/features/home/screens/categories_deal_screen.dart';
import 'package:mobileapp/features/home/screens/home_screen.dart';
import 'package:mobileapp/features/order_details/screens/order_details_screen.dart';
import 'package:mobileapp/features/product_details/screens/product_details_screen.dart';
import 'package:mobileapp/features/search/screens/search_screen.dart';
import 'package:mobileapp/models/order.dart';
import 'package:mobileapp/models/product.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AddProductScreen(),
      );
    case CategoriesDealsScreen.routeName:
      var category = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => CategoriesDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailsScreen.routeName:
      var product = settings.arguments as Product;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = settings.arguments as String;

      return MaterialPageRoute(
        settings: settings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = settings.arguments as Order;

      return MaterialPageRoute(
        settings: settings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}
