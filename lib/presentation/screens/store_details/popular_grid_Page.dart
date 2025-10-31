import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/home/most_popular.dart';
import 'package:freeza_food/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/most_popular/most_popular_cubit.dart';
import '../../../blocs/most_popular/most_popular_state.dart';
import '../../../data/repositories/popular_repository.dart';


class PopularGridPage extends StatelessWidget {

  const PopularGridPage({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularCubit(PopularRepository())..loadPopularItems(),
      child: Scaffold(
        backgroundColor: AppColor.Dark,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomAppbarProfile(
              title: "Most popular",
              icon: Icons.arrow_back_ios,
              ontap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: BlocBuilder<PopularCubit, PopularState>(
              builder: (context, state) {
                if (state is PopularLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PopularError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is PopularLoaded) {
                  final items = state.items;

                  int getCrossAxisCount(double width) {
                    if (width < 600) return 2;
                    if (width < 1000) return 3;
                    return 4;
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = getCrossAxisCount(constraints.maxWidth);

                      return Container(
                        decoration: BoxDecoration(
                          color: AppColor.LightActive,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 5.h,
                              crossAxisSpacing: 12.w,
                              childAspectRatio: 0.92,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return PopularItemCard(
                                isFavorite: item.isFavorite,
                                imagePath: item.image,
                                title: item.nameAr,
                                subtitle: item.restaurantName,
                                price: item.price,
                                oldPrice: null,
                                onFavoriteToggle: () {},
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}

