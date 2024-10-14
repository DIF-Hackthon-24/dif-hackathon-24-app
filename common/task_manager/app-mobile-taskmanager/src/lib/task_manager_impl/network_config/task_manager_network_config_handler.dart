import 'package:core/ioc/di_container.dart';
import 'package:core/task/task_params.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/task_manager_impl/task_manager_impl.dart';

class NetworkConfigTaskParams extends TaskParams {
  final int networkTimeoutInSeconds;
  final Map<String, int> serviceTimeouts;

  NetworkConfigTaskParams({
    required this.networkTimeoutInSeconds,
    required this.serviceTimeouts,
  });
}

extension TaskManagerDataRequestCacheTaskHandler on TaskManager {
  Future<void> executeNetworkConfigTask({TaskParams? params}) async {
    final args = params as NetworkConfigTaskParams;
    final client = DIContainer.container<INetworkClient>(
      NetworkManager.networkClientKey,
    );
    client.setNetworkTimeout(args.networkTimeoutInSeconds, args.serviceTimeouts);
  }
}