import 'package:flutter/material.dart';

import 'widgets/parent_home_body.dart';

class ParentHome extends StatelessWidget {
  const ParentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ParentHomeBody(),
    );
  }
}