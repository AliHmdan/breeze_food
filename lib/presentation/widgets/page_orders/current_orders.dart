// import 'package:freeza_food/core/constans/color.dart';
// import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CurrentOrders extends StatelessWidget {
//   const CurrentOrders({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final orders = [
//       {
//         "restaurant": "Chicken House",
//         "items": "2 items",
//         "total": "25.00\$",
//         "date": "25/5/2025 09:00 PM",
//         "image": "assets/images/003.jpg",
//       },
//       {
//         "restaurant": "Pizza Point",
//         "items": "3 items",
//         "total": "40.00\$",
//         "date": "24/5/2025 08:30 PM",
//         "image": "assets/images/004.jpg",
//       },
//     ];
//
//     return ListView.builder(
//       // padding: const EdgeInsets.all(5),
//       itemCount: orders.length,
//       itemBuilder: (context, index) {
//         final order = orders[index];
//         return Container(
//           height: 110.h,
//           margin: const EdgeInsets.only(bottom: 12),
//           // padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: AppColor.black,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(
//                     // ممكن تغير القيمة حسب اللي يعجبك
//                     50,
//                   ),
//                   child: Image.asset(
//                     order["image"]!,
//                     width: 80.w,
//                     height: 80.h,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               // تفاصيل الطلب
//               // Expanded(
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       CustomSubTitle(
//               //         subtitle: order["restaurant"]!,
//               //         color: AppColor.white,
//               //         fontsize: 14.sp,
//               //       ),
//
//               //       CustomSubTitle(
//               //         subtitle: order["items"]!,
//               //         color: AppColor.white,
//               //         fontsize: 10.sp,
//               //       ),
//
//               //       // SizedBox(height:15.h),
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         children: [
//               //           RichText(
//               //             text: TextSpan(
//               //               children: [
//               //                 TextSpan(
//               //                   text: "Total: ",
//               //                   style: TextStyle(
//               //                     color: AppColor.white,
//               //                     fontSize: 14.sp,
//               //                     fontFamily: "Manrope",
//               //                   ),
//               //                 ),
//               //                 TextSpan(
//               //                   text: "${order["total"]}",
//               //                   style: TextStyle(
//               //                     color: Colors.yellow, // السعر باللون الأصفر
//               //                     fontSize: 12.sp,
//               //                     fontWeight: FontWeight.w400,
//               //                     fontFamily: "Manrope",
//               //                   ),
//               //                 ),
//               //               ],
//               //             ),
//               //           ),
//
//               //           CustomSubTitle(
//               //             subtitle: order["date"]!,
//               //             color: AppColor.white,
//               //             fontsize: 10.sp,
//               //           ),
//               //         ],
//               //       ),
//               //     ],
//               //   ),
//               // ),
//
//               // التاريخ والوقت
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomSubTitle(
//                       subtitle: order["restaurant"]!,
//                       color: AppColor.white,
//                       fontsize: 14.sp,
//                     ),
//
//                     const SizedBox(height: 4),
//                   CustomSubTitle(
//                       subtitle: order["items"]!,
//                       color: AppColor.white,
//                       fontsize: 10.sp,
//                     ),
//
//                     const SizedBox(height: 4),
//                       Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "Total: ",
//                                     style: TextStyle(
//                                       color: AppColor.white,
//                                       fontSize: 14.sp,
//                                       fontFamily: "Manrope",
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "${order["total"]}",
//                                     style: TextStyle(
//                                       color: Colors.yellow, // السعر باللون الأصفر
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w400,
//                                       fontFamily: "Manrope",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                               CustomSubTitle(
//                           subtitle: order["date"]!,
//                           color: AppColor.white,
//                           fontsize: 10.sp,
//                         ),
//                         ],
//                       ),
//
//                   ],
//                 ),
//               ),
//
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/current_orders/current_orders_cubit.dart';
import 'package:freeza_food/blocs/current_orders/current_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';

import '../../../models/current_orders_model.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({super.key});

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  late CurrentOrdersCubit _cubit;
  final token = "YOUR_USER_TOKEN_HERE";

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CurrentOrdersCubit>();
    _cubit.loadCurrentOrders(token);
  }

  Future<void> _refreshOrders() async {
    await _cubit.loadCurrentOrders(token);
  }

  Widget _buildOrderCard(CurrentOrderItem order) {
    return Container(
      height: 110.h,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://syriansociety.org${order.itemImage}",
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  "assets/images/003.jpg",
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSubTitle(
                  subtitle: order.restaurantName,
                  color: AppColor.white,
                  fontsize: 14.sp,
                ),
                const SizedBox(height: 4),
                CustomSubTitle(
                  subtitle: "${order.itemName} (${order.itemQuantity} قطع)",
                  color: AppColor.white,
                  fontsize: 10.sp,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Total: ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 14.sp,
                              fontFamily: "Manrope",
                            ),
                          ),
                          TextSpan(
                            text: "${order.totalPrice.toStringAsFixed(0)} ل.س",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Manrope",
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSubTitle(
                      subtitle: order.createdAt.split("T")[0],
                      color: AppColor.white,
                      fontsize: 10.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentOrdersCubit, CurrentOrdersState>(
      builder: (context, state) {
        if (state is CurrentOrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CurrentOrdersError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        if (state is CurrentOrdersLoaded) {
          if (state.orders.isEmpty) {
            return const Center(
              child: Text(
                "لا توجد طلبات حالية",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshOrders,
            child: ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) =>
                  _buildOrderCard(state.orders[index]),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
