import 'dart:async';


/// Loads the test with fonts, rather than using the 'block test' font
/// [See docs](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Load fonts doesn't currently work as our fonts are no longer defined in this project.
  // As a workaround, we could create a new test-only dependency that has just the trial fonts and nothing else
  // We can then load these fonts from that lib.
  // kTestTheme = await buildTheme();
  return testMain();
}
