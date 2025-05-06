
import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/features/Parent/core/utils/custom_app_bar.dart';
import 'package:edunourish/features/Parent/core/utils/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  
  const BaseScaffold({super.key, required this.child,required this.appBartTitle , this.wantAppBar = true});
  final bool wantAppBar;
  final String appBartTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomBar(),
      appBar: (wantAppBar == false)
      ?  AppBar(
        backgroundColor: ourBackgroundColor,
        automaticallyImplyLeading: false,
        shape:  Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
              title: Row(
                children: [
                  Image.asset(
                    myLogo, // Replace with your image path
                    height: 40,
                  ),
                  const Spacer(),
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
            )
          : null,
      body: Column(
        children: [
          if (wantAppBar) CustomAppBar(appBarTitle: appBartTitle),
          Expanded(child: child),
        ],
      ),
    );
  }
}
