import 'package:flutter_samples/generated/json/base/json_field.dart';
import 'package:flutter_samples/generated/json/user_entity.g.dart';
import 'dart:convert';
export 'package:flutter_samples/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
	late String userId;
	late String username;
	late String email;
	late int mobile;
	late int sex;
	late int age;
	late String nickname;

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
