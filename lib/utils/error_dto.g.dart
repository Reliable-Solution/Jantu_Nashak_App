// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDto _$ErrorDtoFromJson(Map<String, dynamic> json) => ErrorDto(
  data: json['data'] as String?,
  message: json['msg'] as String?,
  success: json['success'] as bool?,
    );

Map<String, dynamic> _$ErrorDtoToJson(ErrorDto instance) => <String, dynamic>{
      'data': instance.data,
      'msg': instance.message,
      'success': instance.success,
    };
