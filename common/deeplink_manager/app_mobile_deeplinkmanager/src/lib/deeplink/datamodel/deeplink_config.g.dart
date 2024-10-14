// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deeplink_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeepLinkConfigData _$DeepLinkConfigDataFromJson(Map<String, dynamic> json) {
  return DeepLinkConfigData(
    deepLinkBaseUrl: json['deepLinkBaseUrl'] as String,
    deepLinkConfigs: (json['deepLinkConfigs'] as List<dynamic>)
        .map((e) => DeepLinkConfig.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DeepLinkConfigDataToJson(DeepLinkConfigData instance) => <String, dynamic>{
      'deepLinkBaseUrl': instance.deepLinkBaseUrl,
      'deepLinkConfigs': instance.deepLinkConfigs.map((e) => e.toJson()).toList(),
    };

DeepLinkConfig _$DeepLinkConfigFromJson(Map<String, dynamic> json) {
  return DeepLinkConfig(
    screen: json['screen'] as String,
    prerequisite: json['prerequisite'] as String,
    arguments: json['arguments'] as List<dynamic>,
  );
}

Map<String, dynamic> _$DeepLinkConfigToJson(DeepLinkConfig instance) => <String, dynamic>{
      'screen': instance.screen,
      'prerequisite': instance.prerequisite,
      'arguments': instance.arguments,
    };
