// import 'package:flutter/material.dart';
//
// import '../screens/home/home.dart';
// import '../shop_page.dart';
//
// class CustomBottomNav extends StatefulWidget {
//   const CustomBottomNav({super.key});
//
//   @override
//   State<CustomBottomNav> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int selectedIndex = 0;
//
//   final List<IconData> icons = [
//     Icons.home_outlined,
//     Icons.storefront_outlined,
//     Icons.favorite_border,
//     Icons.list_alt_outlined,
//   ];
//
//   final List<String> labels = [
//     "Home",
//     "Shop",
//     // "Favorites",
//     // "Orders",
//   ];
//
//   // الصفحات
//   final List<Widget> pages = [
//     const Home(),
//     const Shoppage(),
//     // const FavoritesPage(),
//     // const OrdersPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       body: IndexedStack(
//         index: selectedIndex,
//         children: pages,
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.all(12),
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.grey[850],
//           borderRadius: BorderRadius.circular(40),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(icons.length, (index) {
//             bool isSelected = selectedIndex == index;
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.cyan : Colors.grey[800],
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       icons[index],
//                       color: Colors.white,
//                     ),
//                     if (isSelected) ...[
//                       const SizedBox(width: 6),
//                       Text(
//                         labels[index],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ]
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }