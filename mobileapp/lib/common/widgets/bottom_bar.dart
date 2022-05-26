import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/constants/global_variables.dart';
import 'package:mobileapp/features/account/screens/account_screen.dart';
import 'package:mobileapp/features/home/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomNavbarWidth = 42;
  double bottombarBorderWidth = 5;

  List<Widget> pages = [
    HomeScreen(),
    AccountScreen(),
    Center(
      child: Text("Cart Page"),
    ),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
              icon: Container(
                width: bottomNavbarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottombarBorderWidth,
                ))),
                child: Icon(Icons.home_outlined),
              ),
              label: ''),
          // ACCOUNT
          BottomNavigationBarItem(
              icon: Container(
                width: bottomNavbarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottombarBorderWidth,
                ))),
                child: Icon(Icons.person_outline),
              ),
              label: ''),
          // CART
          BottomNavigationBarItem(
              icon: Container(
                width: bottomNavbarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottombarBorderWidth,
                ))),
                child: Badge(
                  elevation: 0,
                  badgeContent: const Text("2"),
                  badgeColor: Colors.white,
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
              label: ''),
        ],
      ),
    );
  }
}
