import '../domain/enums.dart';

bool shouldReduceMotion({
  required ReducedMotionChoice appChoice,
  required bool platformReduceMotion,
  required bool platformDisableAnimations,
}) =>
    platformReduceMotion ||
    platformDisableAnimations ||
    appChoice == ReducedMotionChoice.reduce;
