import 'dart:convert';

import 'package:flutter_samples/generated/json/base/json_convert_content.dart';

export 'package:flutter_samples/generated/json/result_entity.g.dart';

class ResultListEntity<T> {
  late int code;
  late String msg;
  List<T>? data;

  ResultListEntity();

  static ResultListEntity fromJson(Map<String, dynamic> json, String dataType) {
    final ResultListEntity resultEntity = ResultListEntity();
    final int? code = jsonConvert.convert<int>(json['code']);
    if (code != null) {
      resultEntity.code = code;
    }
    final String? msg = jsonConvert.convert<String>(json['msg']);
    if (msg != null) {
      resultEntity.msg = msg;
    }
    final dynamic data = json['data'];
    final jsonAsTFun = jsonConvert.convertFuncMap[dataType];
    if (data != null && jsonAsTFun != null) {
      resultEntity.data =
          (data as List<dynamic>).map((dynamic e) => jsonAsTFun(e)).toList();
    } else {
      resultEntity.data = data;
    }
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
