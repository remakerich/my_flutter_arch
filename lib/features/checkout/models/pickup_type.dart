import 'package:freezed_annotation/freezed_annotation.dart';

part 'pickup_type.freezed.dart';
part 'pickup_type.g.dart';

@freezed
class PickupType with _$PickupType {
  const PickupType._();

  const factory PickupType({
    required int id,
    @Default('') String name,
    @Default(false) bool delivery,
    @Default('') String city,
    @Default('') String address,
    @Default(0) int sortOrder,
    @Default(false) bool status,
    @Default(null) int? deliveryOrganizationId,
  }) = _PickupType;

  factory PickupType.fromJson(Map<String, dynamic> json) =>
      _$PickupTypeFromJson(json);
}
