import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStores extends StatefulWidget {
  const RatingStores({super.key});

  @override
  State<RatingStores> createState() => _RatingStoresState();
}

class _RatingStoresState extends State<RatingStores> {
  double ratingValue = 4.9; // التقييم الابتدائي

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "|",
            style: TextStyle(color: AppColor.white),
          ),
          RatingBarIndicator(
            rating: ratingValue,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            itemCount: 1, // نجمة واحدة كما في الصورة
            itemSize: 16,
            direction: Axis.horizontal,
          ),


          const SizedBox(width: 4),
          Text(
            ratingValue.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 6),
           Text(
            "|",
            style: TextStyle(color: AppColor.white),
          ),
          const SizedBox(width: 6),
          const Text(
            "500+ Order",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
