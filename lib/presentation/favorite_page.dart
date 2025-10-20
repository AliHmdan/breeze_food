import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/CustomBottomNav.dart';
import 'package:freeza_food/presentation/widgets/custom_appbar_home.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _selectedTab = 0; // 0 = Current orders, 1 = Orders history

  Future<void> _deleteOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Delete refreshed")));
  }

  Widget _buildOrderCard() {
    return Slidable(
      key: const ValueKey(1),
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
          // margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.only(left: 1, right: 10),
          decoration: BoxDecoration(
            color: AppColor.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // صورة الوجبة
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(
                    40,
                  ), // ممكن تغير القيمة حسب اللي يعجبك
                  bottomRight: Radius.circular(40),
                ),
                child: Image.asset(
                  "assets/images/003.jpg",
                  width: 111.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              // تفاصيل الوجبة
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubTitle(
                      subtitle: "Chicken shish",
                      color: AppColor.white,
                      fontsize: 16.sp,
                    ),
                    const SizedBox(height: 4),
                    CustomSubTitle(
                      subtitle: "burger king",
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
                            text: "5.00\$ ",
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

  Widget _buildTabButton(String text, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: !isSelected ? Colors.white : Colors.tealAccent[400],
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(
                top: 4,
              ), // space between text and line
              height: 2, // thickness
              width: 100, // length of the underline
              color: Colors.tealAccent[400], // line color
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],

      body: RefreshIndicator(
        onRefresh: _deleteOrders,
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 30,bottom: 8),
      
          child: Stack(
            children: [
              ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const CustomAppbarHome(title: "Favorite"),
                  SizedBox(height: 20.h),
                  _buildOrderCard(),
      
                  const SizedBox(height: 40),
                ],
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
