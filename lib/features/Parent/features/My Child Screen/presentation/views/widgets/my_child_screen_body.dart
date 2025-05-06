import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/utils/app_router.dart';
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:edunourish/features/Parent/features/Parent%20Home/presentation/views/widgets/build_icon_card.dart';
import 'package:flutter/material.dart';


class MyChildScreenBody extends StatelessWidget {
  const MyChildScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBartTitle: 'My Child',
        child: Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 35),
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: 'Hinted search text',
          //     prefixIcon: const Padding(
          //       padding: EdgeInsets.only(left: 20, right: 20),
          //       child: Icon(Icons.menu, color: ourMainColor),
          //     ),
          //     suffixIcon: const Padding(
          //       padding: EdgeInsets.only(left: 20, right: 20),
          //       child: Icon(Icons.search, color: ourMainColor),
          //     ),
          //     contentPadding: const EdgeInsets.symmetric(vertical: 5),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(15),
                
          //       borderSide:  BorderSide(color: Colors.grey.shade500), // Grey border
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(15),
          //       borderSide:  BorderSide(color: Colors.grey.shade500), // Grey border
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(15),
          //       borderSide:  BorderSide(color: Colors.grey.shade500), // Grey border
          //     ),
          //     filled: true,
          //     fillColor: Colors.white,
          //   ),
          // ),
          _buildChildProfileCard(),
         const SizedBox(height: 20),
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
                  child: const BuildIconCard(label: 'Classes', imagePath: classesImage,imageSize: 72,),
                ),
                InkWell(
                  onTap: () {
                    AppRouter.toAttendenceScreen(context);
                  },
                  child: const BuildIconCard(label: 'Attendance', imagePath: attendanceImage,imageSize: 72,),
                ),
                InkWell(
                    onTap: () {
                      AppRouter.toRestaurantScreen(context);
                    },
                    child: const BuildIconCard(label: 'Food Place', imagePath: restaurantImage,imageSize: 72,)),
                InkWell(
                    onTap: () {
                      AppRouter.toGradeScreen(context);
                    },
                    child: const BuildIconCard(label: 'Grade', imagePath: gradeImage,imageSize: 72,)),
                InkWell(
                    onTap: () {
                      AppRouter.toExamScreen(context);
                    },
                    child: const BuildIconCard(label: 'Exam', imagePath: examImage,imageSize: 72,)),
                InkWell(
                    onTap: () {
                      AppRouter.toBusScreen(context);
                    },
                    child:
                        const BuildIconCard(label: 'Bus', imagePath: theBusLocation,imageSize: 72,)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

Widget _buildChildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ourMainColor, Color(0xFF7986CB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ourMainColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 40,
                color: ourMainColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Sarah Johnson',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Grade 5 • Class A',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ID: 2023-5A-42',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
