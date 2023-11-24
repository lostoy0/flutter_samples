import 'package:flutter_samples/generated/json/base/json_convert_content.dart';
import 'package:flutter_samples/models/user_entity.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    userEntity.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    userEntity.username = username;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    userEntity.email = email;
  }
  final int? mobile = jsonConvert.convert<int>(json['mobile']);
  if (mobile != null) {
    userEntity.mobile = mobile;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    userEntity.sex = sex;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    userEntity.age = age;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    userEntity.nickname = nickname;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['email'] = entity.email;
  data['mobile'] = entity.mobile;
  data['sex'] = entity.sex;
  data['age'] = entity.age;
  data['nickname'] = entity.nickname;
  return data;
}

extension UserEntityExtension on UserEntity {
  UserEntity copyWith({
    String? userId,
    String? username,
    String? email,
    int? mobile,
    int? sex,
    int? age,
    String? nickname,
  }) {
    return UserEntity()
      ..userId = userId ?? this.userId
      ..username = username ?? this.username
      ..email = email ?? this.email
      ..mobile = mobile ?? this.mobile
      ..sex = sex ?? this.sex
      ..age = age ?? this.age
      ..nickname = nickname ?? this.nickname;
  }
}
