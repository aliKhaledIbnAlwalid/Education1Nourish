import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/assets.dart';
import 'build_icon_card.dart';
import 'parent_slider.dart';

class ParentHomeBody extends StatelessWidget {
  const ParentHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Expanded(
        child: Column(
          children: [
            // News Box
            ParentSlider(),

            // Cards Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  InkWell(
                    onTap: () {
                      AppRouter.toTeacherScreen(context);
                    },
                    child: const BuildIconCard(
                        label: 'Teacher',
                        imagePath: teacherHome,
                        top: -60,
                        left: 20,
                        bottom: 40,
                        right: 20),
                  ),
                  InkWell(
                      onTap: () {
                        AppRouter.toMyChildScreen(context);
                      },
                      child: const BuildIconCard(
                          label: 'My child',
                          imagePath: studentHome,
                          top: -50,
                          left: 20,
                          bottom: 40,
                          right: 20)),
                  InkWell(
                    onTap: () {
                      AppRouter.toRestaurantScreen(context);
                    },
                    child: const BuildIconCard(
                        label: 'Food Place',
                        imagePath: restaurantHome,
                        top: 0,
                        left: 20,
                        bottom: 40,
                        right: 20),
                  ),
                  InkWell(
                    onTap: () {
                      AppRouter.toPaymentScreen(context);
                    },
                    child: const BuildIconCard(
                        label: 'Payment',
                        imagePath: paymentHome,
                        top: 10,
                        left: 20,
                        bottom: 50,
                        right: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
