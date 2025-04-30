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
        child: Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Welcome Mohamed',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
           
          const SizedBox(height: 25),
          TextField(
            decoration: InputDecoration(
              hintText: 'Hinted search text',
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Icon(Icons.menu, color: ourMainColor),
              ),
              suffixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Icon(Icons.search, color: ourMainColor),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                
                borderSide:  BorderSide(color: Colors.grey.shade500), // Grey border
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:  BorderSide(color: Colors.grey.shade500), // Grey border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:  BorderSide(color: Colors.grey.shade500), // Grey border
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          
         
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
                    child: const BuildIconCard(label: 'Food Place', imagePath: theRestaurantHome,imageSize: 72,)),
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
                        const BuildIconCard(label: 'Bus', imagePath: busLocation,imageSize: 72,)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
