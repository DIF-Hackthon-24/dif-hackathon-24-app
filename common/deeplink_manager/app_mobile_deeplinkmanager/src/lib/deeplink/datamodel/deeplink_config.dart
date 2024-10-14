import 'package:json_annotation/json_annotation.dart';

part 'deeplink_config.g.dart';

@JsonSerializable(explicitToJson: true)
class DeepLinkConfigData {
  final String deepLinkBaseUrl;
  final List<DeepLinkConfig> deepLinkConfigs;

  DeepLinkConfigData({
    required this.deepLinkBaseUrl,
    required this.deepLinkConfigs,
  });

  factory DeepLinkConfigData.fromJson(Map<String, dynamic> jsonMap) {
    return _$DeepLinkConfigDataFromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => _$DeepLinkConfigDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeepLinkConfig {
  final String screen;
  final String prerequisite;
  final List<dynamic> arguments;
  DeepLinkConfig({
    required this.screen,
    required this.prerequisite,
    required this.arguments,
  });

  factory DeepLinkConfig.fromJson(Map<String, dynamic> jsonMap) {
    return _$DeepLinkConfigFromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => _$DeepLinkConfigToJson(this);

  DeepLinkConfig copyWith({String? message}) => DeepLinkConfig(
        screen: screen,
        prerequisite: prerequisite,
        arguments: arguments,
      );
}
