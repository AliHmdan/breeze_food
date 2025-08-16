import 'package:breezefood/presentation/widgets/CustomBottomNav.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("sope"),),
     bottomNavigationBar: CustomBottomNav( currentIndex: 1),
    );
  }
}
