import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                AppRouter.toListScreen(context);
              },
              icon: SvgPicture.asset(
                listIcon,
                width: 32,
                height: 32,
              ),
            ),
            IconButton(
              onPressed: () {
                AppRouter.toBusScreen(context);
              },
              icon: const Icon(
                Icons.directions_bus_sharp,
                size: 33,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                AppRouter.toParentHome(context);
              },
              icon: SvgPicture.asset(homeIconBottomBar),
            ),
            IconButton(
              onPressed: () {
                AppRouter.toGradeScreen(context);
              },
              icon: SvgPicture.asset('assets/parent/icons/Star.svg'),
            ),
            IconButton(
              onPressed: () {
                AppRouter.toSettingsScreen(context);
              },
              icon: SvgPicture.asset(settingsBottomBar),
            ),
          ],
        ),
      ),
    );
  }
}
