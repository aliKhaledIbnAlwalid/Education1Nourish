import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/constants.dart';

class BuildCard extends StatelessWidget {
  const BuildCard(
    this.title, 
    this.svgIconPath, 
    {super.key, this.onTap}
  );
  
  final String title;
  final String svgIconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      // shadowColor: Color(0xFF1d6a91),
      color:  mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(55),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(55),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Card content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 90),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Positioned SVG Icon outside the card
              Positioned(
                top: -15, // Adjust this to move the icon outside the card
                child: SvgPicture.asset(
                  svgIconPath, // Path to the SVG file
                  height: 90, // Set the height of the SVG
                  width: 90, // Set the width of the SVG
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}