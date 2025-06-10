import 'package:json_annotation/json_annotation.dart';

part 'error_dto.g.dart';

@JsonSerializable()
class ErrorDto {
  ErrorDto({
    this.data,
    this.message,
    this.success,
  });

  bool? success;
  String? data;
  String? message;

  factory ErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDtoToJson(this);
}
