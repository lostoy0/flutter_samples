import 'dart:convert';

import 'package:flutter_samples/ext/common_ext.dart';
import 'package:flutter_samples/generated/json/base/json_convert_content.dart';

export 'package:flutter_samples/generated/json/result_entity.g.dart';

class ResultEntity<T> {
  late int code;
  late String msg;
  T? data;

  ResultEntity();

  factory ResultEntity.fromJson(Map<String, dynamic> json) {
    final ResultEntity<T> resultEntity = ResultEntity();
    final int? code = jsonConvert.convert<int>(json['code']);
    if (code != null) {
      resultEntity.code = code;
    }
    final String? msg = jsonConvert.convert<String>(json['msg']);
    if (msg != null) {
      resultEntity.msg = msg;
    }
    resultEntity.data = JsonConvert.fromJsonAsT<T>(json['data']);
    return resultEntity;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
