import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/custom_appbar_home.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../blocs/favorities/favorite_cubit.dart';
import '../blocs/favorities/favorite_state.dart';
import '../models/favorite_model.dart';
// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});
//
//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }
//
// class _FavoritePageState extends State<FavoritePage> {
//
//   Future<void> _deleteOrders() async {
//     await Future.delayed(const Duration(seconds: 1));
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text("Delete refreshed")));
//   }
//
//   Widget _buildOrderCard() {
//     return Slidable(
//       key: const ValueKey(1),
//       endActionPane: ActionPane(
//         motion: const DrawerMotion(),
//         extentRatio: 0.25,
//         children: [
//           CustomSlidableAction(
//             onPressed: (context) => _deleteOrders(),
//             backgroundColor: AppColor.red,
//             borderRadius: BorderRadius.circular(11.r),
//             child: Center(
//               child: SvgPicture.asset(
//                 "assets/icons/delete.svg",
//                 color: Colors.white,
//                 width: 30.w,
//                 height: 30.h,
//               ),
//             ),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(right: 8),
//         child: Container(
//           // margin: const EdgeInsets.all(12),
//           padding: const EdgeInsets.only(left: 1, right: 10),
//           decoration: BoxDecoration(
//             color: AppColor.black,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Row(
//             children: [
//               // صورة الوجبة
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(0),
//                   bottomLeft: Radius.circular(0),
//                   topRight: Radius.circular(
//                     40,
//                   ), // ممكن تغير القيمة حسب اللي يعجبك
//                   bottomRight: Radius.circular(40),
//                 ),
//                 child: Image.asset(
//                   "assets/images/003.jpg",
//                   width: 111.w,
//                   height: 100.h,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//
//               const SizedBox(width: 12),
//
//               // تفاصيل الوجبة
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomSubTitle(
//                       subtitle: "Chicken shish",
//                       color: AppColor.white,
//                       fontsize: 16.sp,
//                     ),
//                     const SizedBox(height: 4),
//                     CustomSubTitle(
//                       subtitle: "burger king",
//                       color: AppColor.white,
//                       fontsize: 14.sp,
//                     ),
//
//                     const SizedBox(height: 4),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: "Price : ",
//                             style: TextStyle(
//                               color: AppColor.white,
//                               fontFamily: "Manrope",
//                               fontSize: 16.sp,
//                             ),
//                           ),
//
//                           TextSpan(
//                             text: "5.00\$ ",
//                             style: TextStyle(
//                               color: AppColor.yellow,
//                               fontFamily: "Manrope",
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//
//       body: RefreshIndicator(
//         onRefresh: _deleteOrders,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8,right: 8,top: 30,bottom: 8),
//
//           child: Stack(
//             children: [
//               ListView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 children: [
//                   const CustomAppbarHome(title: "Favorite"),
//                   SizedBox(height: 20.h),
//                   _buildOrderCard(),
//
//                   const SizedBox(height: 40),
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late FavoriteCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FavoriteCubit>();
    _cubit.loadFavorites();
  }

  Future<void> _deleteOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Delete refreshed")),
    );
  }

  Widget _buildOrderCard(FavoriteItem item) {
    return Slidable(
      key: ValueKey(item.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          CustomSlidableAction(
            onPressed: (context) => _deleteOrders(),
            backgroundColor: AppColor.red,
            borderRadius: BorderRadius.circular(11.r),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/delete.svg",
                color: Colors.white,
                width: 30.w,
                height: 30.h,
              ),
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Container(
          padding: const EdgeInsets.only(left: 1, right: 10),
          decoration: BoxDecoration(
            color: AppColor.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Image.network(
                  "https://syriansociety.org${item.image}",
                  width: 111.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    "assets/images/003.jpg",
                    width: 111.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubTitle(
                      subtitle: item.nameAr,
                      color: AppColor.white,
                      fontsize: 16.sp,
                    ),
                    const SizedBox(height: 4),
                    CustomSubTitle(
                      subtitle: item.restaurantName,
                      color: AppColor.white,
                      fontsize: 14.sp,
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Price : ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontFamily: "Manrope",
                              fontSize: 16.sp,
                            ),
                          ),
                          TextSpan(
                            text: "${item.price.toStringAsFixed(0)} ل.س",
                            style: TextStyle(
                              color: AppColor.yellow,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          if (state is FavoriteLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(
                child: Text(
                  "لا توجد عناصر في المفضلة",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _cubit.loadFavorites(),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 30, bottom: 8),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const CustomAppbarHome(title: "Favorite"),
                    SizedBox(height: 20.h),
                    for (final f in state.favorites) _buildOrderCard(f),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
