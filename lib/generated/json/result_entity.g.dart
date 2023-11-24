import 'package:flutter_samples/generated/json/base/json_convert_content.dart';
import 'package:flutter_samples/models/result_entity.dart';

ResultEntity $ResultEntityFromJson(Map<String, dynamic> json) {
  final ResultEntity resultEntity = ResultEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    resultEntity.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    resultEntity.msg = msg;
  }
  final dynamic data = json['data'];
  if (data != null) {
    if (data is List) {
      resultEntity.data = jsonConvert.convertListNotNull(data);
    } else {
      resultEntity.data = jsonConvert.convert(data);
    }
  }
  return resultEntity;
}

Map<String, dynamic> $ResultEntityToJson(ResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  data['data'] = entity.data;
  return data;
}

extension ResultEntityExtension on ResultEntity {
  ResultEntity copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) {
    return ResultEntity()
      ..code = code ?? this.code
      ..msg = msg ?? this.msg
      ..data = data ?? this.data;
  }
}
