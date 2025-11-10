import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constans/color.dart';
import '../../data/repositories/discount_repository.dart';
import '../widgets/title/custom_appbar_profile.dart';
import '../widgets/discount_grid_page/discount_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/home/discount.dart';
import '../../../blocs/discount/discount_cubit.dart';

class DiscountGridPage extends StatelessWidget {

  const DiscountGridPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscountCubit(DiscountRepository())..loadDiscounts(),
      child: Scaffold(
        backgroundColor: AppColor.Dark,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomAppbarProfile(
              title: "Discount",
              icon: Icons.arrow_back_ios,
              ontap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: BlocBuilder<DiscountCubit, DiscountState>(
              builder: (context, state) {
                if (state is DiscountLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is DiscountError) {
                  return Center(child: Text("خطأ: ${state.message}"));
                }
                if (state is DiscountLoaded) {
                  final list = state.list;

                  int getCrossAxisCount(double width) {
                    if (width < 600) return 2;
                    if (width < 1000) return 3;
                    return 4;
                  }

                  return LayoutBuilder(
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
                              mainAxisSpacing: 5.h,
                              crossAxisSpacing: 12.w,
                              childAspectRatio: 0.79,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              return Discount(
                                imagePath: item.image,
                                title: item.nameAr,
                                subtitle: item.restaurantName,
                                price: "${item.price} ل.س",
                                discount: item.discountValue.toString(),
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

