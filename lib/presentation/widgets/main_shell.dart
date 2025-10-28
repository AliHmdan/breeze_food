// main_shell.dart
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/favorite_page.dart';
import 'package:breezefood/presentation/screens/home/home.dart';
import 'package:breezefood/presentation/screens/orders.dart';
import 'package:breezefood/presentation/screens/stores_nav_tab.dart';
import 'package:breezefood/presentation/widgets/CustomBottomNav.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  final int initialIndex; // 👈 أضفناه
  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index; // 👈 بدلناها لـ late ونقرأ من widget.initialIndex

  final _pages = const [
    Home(),
    StoresNavTab(),
    FavoritePage(),
    Orders(),
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex; // 👈 نبدأ من الإندكس القادم من الكونستركتور
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      extendBody: true,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavBreeze(
        currentIndex: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}
