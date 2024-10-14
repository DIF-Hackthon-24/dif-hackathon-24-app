import 'package:kiwi/kiwi.dart';

/// A wrapper for the dependency injection in the project.
abstract class DIContainer {

  // the real ioc container that allows the registration or retrieval of
  // dependencies. if we decide to switch to a custom solution in the future
  // we can retain the method signatures and keep the container.
  static final KiwiContainer container = KiwiContainer();
}