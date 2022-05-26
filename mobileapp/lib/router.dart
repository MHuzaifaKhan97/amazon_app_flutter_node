import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/bottom_bar.dart';
import 'package:mobileapp/features/admin/screens/add_product_screen.dart';
import 'package:mobileapp/features/auth/screens/auth_screen.dart';
import 'package:mobileapp/features/home/screens/categories_deal_screen.dart';
import 'package:mobileapp/features/home/screens/home_screen.dart';
import 'package:mobileapp/features/search/screens/search_screen.dart';

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
