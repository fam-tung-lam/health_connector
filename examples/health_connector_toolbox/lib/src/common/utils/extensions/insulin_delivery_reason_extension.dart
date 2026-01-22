import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

extension InsulinDeliveryReasonExtension on InsulinDeliveryReason {
  String get displayName => switch (this) {
    InsulinDeliveryReason.basal => AppTexts.basal,
    InsulinDeliveryReason.bolus => AppTexts.bolus,
  };
}
