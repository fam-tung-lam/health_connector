import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

extension BasalBodyTemperatureMeasurementLocationExtension
    on BasalBodyTemperatureMeasurementLocation {
  String get displayName {
    switch (this) {
      case BasalBodyTemperatureMeasurementLocation.unknown:
        return AppTexts.unknown;
      case BasalBodyTemperatureMeasurementLocation.armpit:
        return AppTexts.armpit;
      case BasalBodyTemperatureMeasurementLocation.ear:
        return AppTexts.ear;
      case BasalBodyTemperatureMeasurementLocation.finger:
        return AppTexts.finger;
      case BasalBodyTemperatureMeasurementLocation.forehead:
        return AppTexts.forehead;
      case BasalBodyTemperatureMeasurementLocation.mouth:
        return AppTexts.mouth;
      case BasalBodyTemperatureMeasurementLocation.rectum:
        return AppTexts.rectum;
      case BasalBodyTemperatureMeasurementLocation.temporalArtery:
        return AppTexts.temporalArtery;
      case BasalBodyTemperatureMeasurementLocation.toe:
        return AppTexts.toe;
      case BasalBodyTemperatureMeasurementLocation.vagina:
        return AppTexts.vagina;
      case BasalBodyTemperatureMeasurementLocation.wrist:
        return AppTexts.wrist;
    }
  }
}
