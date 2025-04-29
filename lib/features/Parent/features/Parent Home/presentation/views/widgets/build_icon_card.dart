
import 'package:edunourish/features/Parent/core/utils/constants.dart';
import 'package:flutter/material.dart';

class BuildIconCard extends StatelessWidget {
  const BuildIconCard({
    super.key,
    required this.label,
    required this.imagePath,
    required this.top,
    required this.left,
    required this.bottom,
    required this.right,
  });

  final String label;
  final String imagePath;
  final double top;
  final double left;
  final double bottom;
  final double right;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip
          .none, // Allows elements to go outside the bounds of the container
      children: [
        // Background Card
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          // elevation: 4, // Optional: Add elevation for a shadow effect
          color: mainColor,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        // Positioned Image
        Positioned(
          top: top, // Adjust to make the image exceed the container
          left: left,
          bottom: bottom,
          right: right, // Adjust horizontal alignment
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitHeight,
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
