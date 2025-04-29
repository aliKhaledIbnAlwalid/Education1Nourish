import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

import 'build_card.dart';

class MyChildScreenBody extends StatelessWidget {
  const MyChildScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hi\nmohamed',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'Hinted search text',
              prefixIcon: const Padding(
                padding: EdgeInsets.only(
                    left: 20, right: 20), // Add space around the icon
                child: Icon(Icons.menu, color: Colors.black),
              ), // Icon before the text
              suffixIcon: const Padding(
                padding: EdgeInsets.only(
                    left: 20, right: 20), // Add space around the icon
                child: Icon(Icons.search, color: Colors.black),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5), // Add space
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50), // Circular shape
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          // SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 36,
              mainAxisSpacing: 16,
              padding: const EdgeInsets.all(20),
              children: [
                InkWell(
                  onTap: () {
                    AppRouter.toClassesScreen(context);
                  },
                  child: const BuildCard(
                    'classes',
                    'assets/parent/icons/Calendar.svg',
                  ),
                ),
                InkWell(
                  onTap: () {
                    AppRouter.toAttendenceScreen(context);
                  },
                  child: const BuildCard(
                    'attendance',
                    attendenceIcon,
                  ),
                ),
                InkWell(
                    onTap: () {
                      AppRouter.toRestaurantScreen(context);
                    },
                    child: const BuildCard(
                        'food place', 'assets/parent/icons/icon.svg')),
                InkWell(
                    onTap: () {
                      AppRouter.toGradeScreen(context);
                    },
                    child: const BuildCard(
                        'grade', 'assets/parent/icons/Star.svg')),
                InkWell(
                    onTap: () {
                      AppRouter.toExamScreen(context);
                    },
                    child: const BuildCard(
                        'Exam', 'assets/parent/icons/Book.svg')),
                InkWell(
                    onTap: () {
                      AppRouter.toBusScreen(context);
                    },
                    child:
                        const BuildCard('BUS', 'assets/parent/icons/bus.svg')),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
