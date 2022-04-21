import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_type.freezed.dart';
part 'payment_type.g.dart';

@freezed
class PaymentType with _$PaymentType {
  const PaymentType._();

  const factory PaymentType({
    required int id,
    @Default('') String name,
    @Default(false) bool onlyPhysicalPerson,
    @Default(0) int sortOrder,
  }) = _PaymentType;

  factory PaymentType.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeFromJson(json);
}
