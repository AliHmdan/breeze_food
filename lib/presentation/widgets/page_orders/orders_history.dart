import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/CustomBottomNav.dart';
import 'package:freeza_food/presentation/widgets/custom_appbar_home.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({super.key});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  int _selectedTab = 0; // 0 = Current orders, 1 = Orders history

  Future<void> _refreshedOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(" refreshed Orders")));
  }

  Widget _buildOrderCard() {
    return Slidable(
      key: const ValueKey(1),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          CustomSlidableAction(
            onPressed: (context) => _refreshedOrders(),
            backgroundColor: AppColor.black,
            borderRadius: BorderRadius.circular(11.r),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/refresh.svg",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius:  BorderRadius.circular(
                    // ممكن تغير القيمة حسب اللي يعجبك
                   50
                  ),
                  child: Image.asset(
                    "assets/images/003.jpg",
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
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
    return  RefreshIndicator(
        onRefresh: _refreshedOrders,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
                   
        
            _buildOrderCard(),
                
            const SizedBox(height: 40),
          ],
        ),
      
    );
  }
}
