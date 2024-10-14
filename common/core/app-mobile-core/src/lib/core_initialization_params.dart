
import 'module/module.dart';
import 'navigation/i_route_manager.dart';

class CoreInitializationParams {
  CoreInitializationParams({
    required this.identifier,
    required this.moduleInstance,
    required this.routeManager,
  });

  final String identifier;
  final Module moduleInstance;
  final IRouteManager routeManager;
}
