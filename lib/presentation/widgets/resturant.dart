// import 'package:breezefood/data/model/restaurant.dart';
// import 'package:flutter/material.dart';

// class RestaurantCard extends StatelessWidget {
//   final Restaurant data;
//   final VoidCallback? onTap;

//   const RestaurantCard({super.key, required this.data, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(24),
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: const [
//             BoxShadow(
//               blurRadius: 18,
//               color: Colors.black12,
//               offset: Offset(0, 8),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(24),
//           child: AspectRatio(
//             aspectRatio: 16 / 6.2, // ارتفاع مناسب للكارد – عدّله إذا رغبت
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 // الصورة الخلفية
//                 FadeInImage.assetNetwork(
//                   placeholder: 'assets/placeholder.png', // ضع بلايسهولدر بسيط
//                   image: data.imageUrl,
//                   fit: BoxFit.cover,
//                 ),

//                 // تدرّج داكن للقراءة الواضحة
//                 Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Color(0xAA000000),
//                         Color(0x33000000),
//                         Color(0xAA000000),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // شارة الوقت (يمين-أعلى)
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: _TimeChip(minutes: data.etaMinutes),
//                 ),

//                 // شريط التقييم والطلبات (يسار-أعلى)
//                 Positioned(
//                   top: 10,
//                   left: 14,
//                   child: _RatingOrdersRow(
//                     rating: data.rating,
//                     orders: data.ordersCount,
//                   ),
//                 ),

//                 // العنوان في الوسط
//                 Center(
//                   child: Text(
//                     data.name,
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       height: 1.2,
//                       fontWeight: FontWeight.w700,
//                       shadows: [
//                         Shadow(
//                           color: Colors.black45,
//                           blurRadius: 6,
//                           offset: Offset(0, 1),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TimeChip extends StatelessWidget {
//   final int minutes;
//   const _TimeChip({required this.minutes});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.35),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white24, width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.schedule_rounded, size: 16, color: Colors.white),
//           const SizedBox(width: 6),
//           Text(
//             '${minutes}M',
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _RatingOrdersRow extends StatelessWidget {
//   final double rating;
//   final int orders;

//   const _RatingOrdersRow({
//     required this.rating,
//     required this.orders,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.35),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.white24, width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.star_rounded, color: Color(0xFFFFD54F), size: 18),
//           const SizedBox(width: 4),
//           Text(
//             rating.toStringAsFixed(1),
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//           ),
//           _dot(),
//           Text(
//             '${_prettyOrders(orders)} Order',
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _dot() => const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8),
//         child: Text('•', style: TextStyle(color: Colors.white70, fontSize: 16)),
//       );

//   static String _prettyOrders(int n) {
//     if (n >= 1000) {
//       final k = (n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1);
//       return '${k}K+';
//     }
//     return '$n+';
//   }
// }
