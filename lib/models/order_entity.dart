import 'package:flutter_samples/generated/json/base/json_field.dart';
import 'package:flutter_samples/generated/json/order_entity.g.dart';
import 'dart:convert';
export 'package:flutter_samples/generated/json/order_entity.g.dart';

@JsonSerializable()
class OrderEntity {
	late String orderId;
	late String goodsName;
	late double unitPrice;
	late int count;
	late double freight;
	late String receiverName;
	late String receiverAddress;
	late int receiverMobile;

	OrderEntity();

	factory OrderEntity.fromJson(Map<String, dynamic> json) => $OrderEntityFromJson(json);

	Map<String, dynamic> toJson() => $OrderEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
