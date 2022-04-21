import 'package:freezed_annotation/freezed_annotation.dart';

import 'delivery_type.dart';
import 'payment_type.dart';
import 'pickup_type.dart';

part 'checkout_types.freezed.dart';
part 'checkout_types.g.dart';

@freezed
class CheckoutTypes with _$CheckoutTypes {
  const CheckoutTypes._();

  const factory CheckoutTypes({
    @Default([]) List<DeliveryType> deliveryTypes,
    @Default([]) List<PickupType> pickupTypes,
    @Default([]) List<PaymentType> paymentTypes,
  }) = _CheckoutTypes;

  factory CheckoutTypes.fromJson(Map<String, dynamic> json) =>
      _$CheckoutTypesFromJson(json);
}
