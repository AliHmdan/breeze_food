// main_shell.dart
import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/favorite_page.dart';
import 'package:freeza_food/presentation/screens/home/home.dart';
import 'package:freeza_food/presentation/screens/orders.dart';
import 'package:freeza_food/presentation/screens/stores_nav_tab.dart';
import 'package:freeza_food/presentation/widgets/CustomBottomNav.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final List<Widget> _pages = const [
    Home(),     // ✅ المحتوى فقط
    StoresNavTab(),          // متجرك
    FavoritePage(),
    Orders(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: SafeArea(
        child: Custombottomnav(
         
        ),
      ),
    );
  }
}
