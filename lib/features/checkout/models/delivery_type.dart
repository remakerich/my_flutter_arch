import 'pickup_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_type.freezed.dart';
part 'delivery_type.g.dart';

@freezed
class DeliveryType with _$DeliveryType {
  const DeliveryType._();

  const factory DeliveryType({
    required int id,
    @Default('') String title,
    @Default('') String slug,
    @Default(false) bool status,
    @Default([]) List<PickupType> deliveryTypes,
  }) = _DeliveryType;

  factory DeliveryType.fromJson(Map<String, dynamic> json) =>
      _$DeliveryTypeFromJson(json);
}
