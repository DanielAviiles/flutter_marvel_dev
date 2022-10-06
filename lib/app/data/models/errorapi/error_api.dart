import 'package:flutter_marvel_dev/app/data/models/commonapi/common_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_api.g.dart';

@JsonSerializable()
class ErrorApi extends CommonApi {
  ErrorApi(
      {int? statusCode,
      String? detail,
      String? key,
      String? message,
      String? messageKey,
      this.stackTrace})
      : super(
            statusCode: statusCode,
            detail: detail,
            key: key,
            message: message,
            messageKey: messageKey);
  factory ErrorApi.fromJson(Map<String, dynamic> json) =>
      _$ErrorApiFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ErrorApiToJson(this);
  String? stackTrace;
}
