import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:freeza_food/presentation/widgets/home/most_popular.dart'
    show PopularItemCard;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/data/model/home_model.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({super.key, this.mostPopular});

  final List<MenuItemModel>? mostPopular;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
        children: [
          CustomTitleSection(
            title: "Most popular",
            all: "All",
            icon: Icons.arrow_forward_ios_outlined,
            ontap: () {
              Navigator.of(context).pushNamed(AppRoute.PopularGridPage);
            },
          ),
          const SizedBox(height: 10),
          RepaintBoundary(
            child: Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 8,
                right: 0.2,
              ),
              decoration: BoxDecoration(
                color: AppColor.LightActive,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 178,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / 2.3;
                  final items = (mostPopular != null && mostPopular!.isNotEmpty)
                      ? mostPopular!
                      : List.generate(0, (_) => null);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final menu = (items[index] is MenuItemModel)
                          ? items[index] as MenuItemModel
                          : null;
                      final title = menu?.name ?? '';
                      final subtitle = menu?.description ?? '';
                      final price = menu != null ? menu.basePrice : '';

                      return Container(
                        width: itemWidth,
                        margin: EdgeInsets.only(right: 10.w),
                        child: PopularItemCard(
                          imagePath: 'assets/images/004.jpg',
                          title: title,
                          subtitle: subtitle,
                          price: price,
                          onFavoriteToggle: () {},
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
