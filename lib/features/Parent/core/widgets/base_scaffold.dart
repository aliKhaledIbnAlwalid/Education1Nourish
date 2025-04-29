
import 'package:edunourish/features/Parent/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/utils/custom_app_bar.dart';
import 'package:edunourish/features/Parent/core/utils/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  
  const BaseScaffold({super.key, required this.child,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: const CustomBottomBar(),
        body: Column(
          children: [const CustomAppBar(), Expanded(child: child)],
        ),
      ),
    );
  }
}
