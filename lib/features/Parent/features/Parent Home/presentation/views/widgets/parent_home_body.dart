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
      appBartTitle: '',
      wantAppBar: false,
      child: Expanded(
        child: Column(
          children: [
            // News Box
            const ParentSlider(),

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
                        imagePath: theTeacherHome,
                        ),
                  ),
                  InkWell(
                      onTap: () {
                        AppRouter.toMyChildScreen(context);
                      },
                      child: const BuildIconCard(
                          label: 'My child',
                          imagePath: theStudentHome,
                          )),
                  InkWell(
                    onTap: () {
                      AppRouter.toRestaurantScreen(context);
                    },
                    child: const BuildIconCard(
                        label: 'Food Place',
                        imagePath: restaurantImage,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      AppRouter.toPaymentScreen(context);
                    },
                    child: const BuildIconCard(
                        label: 'Payment',
                        imagePath: paymentHome,
                        ),
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
