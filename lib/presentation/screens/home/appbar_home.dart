import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/presentation/widgets/auth/custom_search.dart';
import 'package:freeza_food/presentation/widgets/custom_appbar_home.dart';
import 'package:flutter/material.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
      child: Column(children: [
         CustomAppbarHome(
                  title: "Deliver to",
                  subtitle: "Poplar Ave,CA",
                  image: "assets/icons/location.svg",
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.profile);
                  },
                  icon: Icons.keyboard_arrow_down,
                ),
                const SizedBox(height: 15),
                CustomSearch(
                  hint: 'Search',
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.search);
                  },
                ),
      ],
        
      ),
    );
  }
}