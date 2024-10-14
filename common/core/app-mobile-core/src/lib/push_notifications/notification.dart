// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

class Notification {
  final int? id;
  final String? tag;
  final String? title;
  final String? body;
  final String? actionUrl;
  final String? iconUrl;
  final Map<String, dynamic>? data;

  Notification(
    this.id,
    this.tag,
    this.title,
    this.body,
    this.actionUrl,
    this.iconUrl,
    this.data,
  );

  Notification.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        tag = json['tag'] as String?,
        title = json['title'] as String?,
        body = json['body'] as String?,
        actionUrl = json['actionUrl'] as String?,
        iconUrl = json['iconUrl'] as String?,
        data = json['data'] as Map<String, dynamic>?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'tag': tag,
        'title': title,
        'body': body,
        'actionUrl': actionUrl,
        'iconUrl': iconUrl,
        'data': data,
      };
}


class SilentNotification {
  @JsonKey(name: 'isSilent')
  final dynamic isSilent;
  
  @JsonKey(name: 'type')
  final String? type;

  SilentNotification({
    this.isSilent,
    this.type,
  });

  factory SilentNotification.fromMap(Map<String, dynamic> map) {
    return SilentNotification(
      isSilent: map['isSilent'],
      type: map['type'] != null ? map['type'] as String : '',
    );
  }
}
