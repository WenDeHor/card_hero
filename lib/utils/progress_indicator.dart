import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:card_hero/utils/constants.dart';

class ProgressIndicatorUtils {

  StepProgressIndicator getProgressIndicator(int currentStep) {
    return StepProgressIndicator(
      totalSteps: totalSteps,
      currentStep: currentStep,
      size: size,
      padding: padding,
      selectedColor: gradientColor1,
      unselectedColor: gradientColor2,
      roundedEdges: Radius.circular(10),
      selectedGradientColor: LinearGradient(
        begin: gradientStart,
        end: gradientEnd,
        colors: [gradientColor1, gradientColor2],
      ),
      unselectedGradientColor: LinearGradient(
        begin: gradientStart,
        end: gradientEnd,
        colors: [gradientColor3, gradientColor4],
      ),
    );
  }
}
