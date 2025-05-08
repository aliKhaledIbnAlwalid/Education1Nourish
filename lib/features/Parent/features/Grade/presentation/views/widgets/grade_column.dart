import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/utils/styles.dart';
import 'package:flutter/material.dart';

class GradeColumn extends StatefulWidget {
  final String label;
  final double grade;
  final bool isAnimated;
  final Duration animationDuration;
  
  const GradeColumn({
    super.key,
    required this.label,
    required this.grade,
    required this.isAnimated,
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  _GradeColumnState createState() => _GradeColumnState();
}

class _GradeColumnState extends State<GradeColumn> {
  late bool _shouldAnimate;

  @override
  void initState() {
    super.initState();
    _shouldAnimate = widget.isAnimated;
  }

  // Compute percentage for the progress indicator
  double get _percentage => widget.grade / 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: mainText14.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        _shouldAnimate
            ? TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: _percentage),
                duration: widget.animationDuration,
                onEnd: () {
                  setState(() {
                    _shouldAnimate = false;
                  });
                },
                builder: (context, value, child) {
                  return _buildGradeIndicator(value);
                },
              )
            : _buildGradeIndicator(_percentage),
        const SizedBox(height: 8),
        Text(
          '${widget.grade.toInt()}%',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ourMainColor,
          ),
        ),
      ],
    );
  }
  // value : animation progress value (0.0 to 1.0) that controls how full the circular progress indicator appears

  Widget _buildGradeIndicator(double value) {
    final letter = _getLetterGrade(widget.grade);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 6,
            backgroundColor: Colors.grey.shade200,
            color: ourMainColor,
          ),
        ),
        Text(
          letter,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ourMainColor,
          ),
        ),
      ],
    );
  }

  String _getLetterGrade(double grade) {
    if (grade >= 90) return 'A';
    if (grade >= 80) return 'B';
    if (grade >= 70) return 'C';
    if (grade >= 60) return 'D';
    return 'F';
  }
}
