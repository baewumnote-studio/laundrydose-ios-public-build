import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/accessibility/motion_preferences.dart';
import 'package:laundry_dose/core/domain/enums.dart';

void main() {
  test('iOS reduce motion always wins', () {
    for (final choice in ReducedMotionChoice.values) {
      expect(
        shouldReduceMotion(
          appChoice: choice,
          platformReduceMotion: true,
          platformDisableAnimations: false,
        ),
        isTrue,
      );
    }
  });
  test(
    'disable animations always wins',
    () => expect(
      shouldReduceMotion(
        appChoice: ReducedMotionChoice.allow,
        platformReduceMotion: false,
        platformDisableAnimations: true,
      ),
      isTrue,
    ),
  );
  test(
    'app reduce adds a request',
    () => expect(
      shouldReduceMotion(
        appChoice: ReducedMotionChoice.reduce,
        platformReduceMotion: false,
        platformDisableAnimations: false,
      ),
      isTrue,
    ),
  );
}
