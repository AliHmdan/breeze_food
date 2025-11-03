import 'package:freeza_food/presentation/screens/add_order/add_new_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constans/color.dart';
import '../button/custom_button.dart';
import '../title/custom_sub_title.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 1; // يبدأ من 1
  double pricePerItem = 5.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // صندوق العدّاد
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // زر ناقص
                InkWell(
                  onTap: () {
                    setState(() {
                      if (count > 1) count--; // الشرط يمنع النزول تحت 1
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // العدد

                CustomSubTitle(subtitle: "$count", color: AppColor.white, fontsize: 18.sp)
                ,const SizedBox(width: 10),
                // زر زائد
                InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.cyan,
                    radius: 16,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // زر ADD

          Expanded(
            child: CustomButton(
              title: "ADD ${(count * pricePerItem).toStringAsFixed(2)}\$",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewMeal(
                      categories: ["Burger", "Chrispy", "India food", "Home"],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
