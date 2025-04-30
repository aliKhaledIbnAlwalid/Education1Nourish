import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           
          InkWell(
              onTap: () {
                AppRouter.toBack(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_sharp,
                size: 30,
                color: ourMainColor,
              )),
          InkWell(
              onTap: () {
                AppRouter.toNotifications(context);
              },
              child: const Icon(
                Icons.notifications_none,
                size: 30,
                color: ourMainColor,
              )),
          
        ],
      ),
    );
  }
}
