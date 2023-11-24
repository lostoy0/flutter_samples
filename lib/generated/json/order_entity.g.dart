import 'package:flutter_samples/generated/json/base/json_convert_content.dart';
import 'package:flutter_samples/models/order_entity.dart';

OrderEntity $OrderEntityFromJson(Map<String, dynamic> json) {
  final OrderEntity orderEntity = OrderEntity();
  final String? orderId = jsonConvert.convert<String>(json['orderId']);
  if (orderId != null) {
    orderEntity.orderId = orderId;
  }
  final String? goodsName = jsonConvert.convert<String>(json['goodsName']);
  if (goodsName != null) {
    orderEntity.goodsName = goodsName;
  }
  final double? unitPrice = jsonConvert.convert<double>(json['unitPrice']);
  if (unitPrice != null) {
    orderEntity.unitPrice = unitPrice;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    orderEntity.count = count;
  }
  final double? freight = jsonConvert.convert<double>(json['freight']);
  if (freight != null) {
    orderEntity.freight = freight;
  }
  final String? receiverName = jsonConvert.convert<String>(
      json['receiverName']);
  if (receiverName != null) {
    orderEntity.receiverName = receiverName;
  }
  final String? receiverAddress = jsonConvert.convert<String>(
      json['receiverAddress']);
  if (receiverAddress != null) {
    orderEntity.receiverAddress = receiverAddress;
  }
  final int? receiverMobile = jsonConvert.convert<int>(json['receiverMobile']);
  if (receiverMobile != null) {
    orderEntity.receiverMobile = receiverMobile;
  }
  return orderEntity;
}

Map<String, dynamic> $OrderEntityToJson(OrderEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderId'] = entity.orderId;
  data['goodsName'] = entity.goodsName;
  data['unitPrice'] = entity.unitPrice;
  data['count'] = entity.count;
  data['freight'] = entity.freight;
  data['receiverName'] = entity.receiverName;
  data['receiverAddress'] = entity.receiverAddress;
  data['receiverMobile'] = entity.receiverMobile;
  return data;
}

extension OrderEntityExtension on OrderEntity {
  OrderEntity copyWith({
    String? orderId,
    String? goodsName,
    double? unitPrice,
    int? count,
    double? freight,
    String? receiverName,
    String? receiverAddress,
    int? receiverMobile,
  }) {
    return OrderEntity()
      ..orderId = orderId ?? this.orderId
      ..goodsName = goodsName ?? this.goodsName
      ..unitPrice = unitPrice ?? this.unitPrice
      ..count = count ?? this.count
      ..freight = freight ?? this.freight
      ..receiverName = receiverName ?? this.receiverName
      ..receiverAddress = receiverAddress ?? this.receiverAddress
      ..receiverMobile = receiverMobile ?? this.receiverMobile;
  }
}
