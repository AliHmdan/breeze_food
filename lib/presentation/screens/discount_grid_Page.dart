import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constans/color.dart';
import '../widgets/title/custom_appbar_profile.dart';
import '../widgets/discount_grid_page/discount_details.dart';

class DiscountGridPage extends StatelessWidget {
  const DiscountGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات مؤقتة
    final List<Map<String, String>> items = List.generate(
      10,
      (index) => {
        "imagePath": "assets/images/004.jpg",
        "title": "Chicken shish",
        "subtitle": "burger king",
        "price": "2.00\$",
        "discount": "50",
      },
    );

    // تحديد عدد الأعمدة بشكل responsive
    int getCrossAxisCount(double width) {
      if (width < 600) {
        return 2; // موبايل
      } else if (width < 1000) {
        return 3; // تابلت
      } else {
        return 4; // ويب
      }
    }

    return Scaffold(
      backgroundColor: AppColor.Dark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h), // ارتفاع الـ AppBar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomAppbarProfile(
            title: "Discount",
            icon: Icons.arrow_back_ios,
            ontap: () {
             Navigator.of(context).pushNamedAndRemoveUntil(
                                    "/home",
                                    (route) => false,
                                  );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = getCrossAxisCount(constraints.maxWidth);

            return Container(
              width: double.infinity,
              height: double.infinity,

              decoration: BoxDecoration(
                color: AppColor.LightActive,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: GridView.builder(
  physics: const BouncingScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: crossAxisCount,
    mainAxisSpacing: 5.h,   // ✅ المسافة الطولية بين الصفوف
    crossAxisSpacing: 12.w,  // ✅ المسافة العرضية بين الأعمدة
    childAspectRatio: 1.1,  // ✅ نسبة العرض للارتفاع
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return DiscountDetails(
      imagePath: item["imagePath"]!,
      title: item["title"]!,
      subtitle: item["subtitle"]!,
      price: item["price"]!,
      discount: item["discount"]!,
      onFavoriteToggle: () {
        debugPrint("Favorite toggled for ${item["title"]}");
      },
    );
  },
)

              ),
            );
          },
        ),
      ),
    );
  }
}
