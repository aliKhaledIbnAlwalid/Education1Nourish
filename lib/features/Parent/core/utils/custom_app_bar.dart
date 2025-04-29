
import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                AppRouter.toNotifications(context);
              },
              child: const Icon(
                Icons.notifications_none,
                size: 30,
              )),
          Image.asset(
            logo,
            width: 42,
            height: 42,
          ),
        ],
      ),
    );
  }
}
