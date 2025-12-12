import 'package:health_connector/health_connector.dart';

/// Centralized collection of all text strings used throughout the application.
///
/// This class provides a single source of truth for all UI text, making it
/// easier to maintain, localize, and update text content.
abstract final class AppTexts {
  // ==========================================================================
  // App Titles
  // ==========================================================================
  static const String healthConnectorToolbox = 'Health Connector Toolbox';

  // ==========================================================================
  // Common UI Elements
  // ==========================================================================
  static const String retry = 'Retry';
  static const String save = 'Save';
  static const String pleaseSelect = 'Please select';

  // ==========================================================================
  // Common Labels
  // ==========================================================================
  static const String id = 'ID';
  static const String status = 'Status';
  static const String time = 'Time';
  static const String date = 'Date';
  static const String startDate = 'Start Date';
  static const String startTime = 'Start Time';
  static const String endDate = 'End Date';
  static const String endTime = 'End Time';
  static const String dataType = 'Data Type';
  static const String value = 'Value';
  static const String valueType = 'Value Type';
  static const String metric = 'Metric';
  static const String type = 'Type';
  static const String name = 'Name';
  static const String count = 'Count';
  static const String duration = 'Duration';
  static const String deviceLabel = 'Device';
  static const String recording = 'Recording';
  static const String recordingMethod = 'Recording Method';
  static const String sleepStageType = 'Sleep Stage Type';

  // ==========================================================================
  // Common Status Values
  // ==========================================================================
  static const String unknown = 'Unknown';
  static const String granted = 'granted';
  static const String denied = 'denied';
  static const String available = 'Available';
  static const String unavailable = 'Unavailable';
  static const String notRequested = 'Not requested';
  static const String notAvailable = 'N/A';
  static const String nullValue = 'none';

  // ==========================================================================
  // Health Platforms
  // ==========================================================================
  static const String appleHealth = 'Apple Health';
  static const String healthConnect = 'Health Connect';

  // ==========================================================================
  // Health Data Types
  // ==========================================================================
  static const String steps = 'Steps';
  static const String stepsLabel = 'steps';
  static const String stepsDescription = 'Step count data over a time interval';
  static const String stepCount = 'Step Count';
  static const String weight = 'Weight';
  static const String weightDescription =
      'Body weight measurement at a point in time';
  static const String weightValue = 'Weight Value (kg)';
  static const String weightKg = 'Weight (kg)';
  static const String weightLbs = 'Weight (lbs)';
  static const String weightGrams = 'Weight (g)';
  static const String distance = 'Distance';
  static const String distanceDescription =
      'Distance traveled over a time interval';
  static const String distanceValue = 'Distance Value (m)';
  static const String distanceMeters = 'Distance (m)';
  static const String distanceKm = 'Distance (km)';
  static const String activeCaloriesBurned = 'Active Calories Burned';
  static const String activeCaloriesBurnedDescription =
      'Active calories burned during physical activity over a time interval';
  static const String activeCaloriesBurnedValue =
      'Active Calories Burned (kcal)';
  static const String activeCaloriesBurnedKcal = 'Active Calories (kcal)';
  static const String activeCaloriesBurnedCal = 'Active Calories (cal)';
  static const String floorsClimbed = 'Floors Climbed';
  static const String floorsClimbedDescription =
      'Number of floors (flights of stairs) climbed over a time interval';
  static const String floorsClimbedValue = 'Floors Climbed';
  static const String floorsClimbedLabel = 'floors';
  static const String wheelchairPushes = 'Wheelchair Pushes';
  static const String wheelchairPushesDescription =
      'Number of wheelchair pushes performed over a time interval';
  static const String wheelchairPushesValue = 'Wheelchair Pushes';
  static const String wheelchairPushesLabel = 'pushes';
  static const String height = 'Height';
  static const String heightDescription =
      'Body height measurement at a point in time';
  static const String heightValue = 'Height Value (m)';
  static const String heightMeters = 'Height (m)';
  static const String heightCm = 'Height (cm)';
  static const String bodyFatPercentage = 'Body Fat Percentage';
  static const String bodyFatPercentageDescription =
      'Body fat percentage measurement at a point in time';
  static const String bodyFatPercentageValue = 'Body Fat Percentage (%)';
  static const String bodyFatPercentagePercent = 'Body Fat Percentage (%)';
  static const String leanBodyMass = 'Lean Body Mass';
  static const String leanBodyMassDescription =
      'Lean body mass measurement at a point in time';
  static const String leanBodyMassValue = 'Lean Body Mass (kg)';
  static const String leanBodyMassKg = 'Lean Body Mass (kg)';
  static const String leanBodyMassLbs = 'Lean Body Mass (lbs)';
  static const String leanBodyMassGrams = 'Lean Body Mass (g)';
  static const String bodyTemperature = 'Body Temperature';
  static const String bodyTemperatureDescription =
      'Body temperature measurement at a point in time';
  static const String bodyTemperatureValue = 'Body Temperature (°C)';
  static const String bodyTemperatureCelsius = 'Body Temperature (°C)';
  static const String bodyTemperatureFahrenheit = 'Body Temperature (°F)';
  static const String bodyTemperatureKelvin = 'Body Temperature (K)';
  static const String hydration = 'Hydration';
  static const String hydrationDescription =
      'Water intake over a time interval';
  static const String hydrationValue = 'Hydration Value (L)';
  static const String hydrationLiters = 'Hydration (L)';
  static const String hydrationMilliliters = 'Hydration (mL)';
  static const String hydrationFluidOunces = 'Hydration (fl oz)';
  static const String bloodPressure = 'Blood Pressure';
  static const String bloodPressureDescription =
      'Blood pressure measurement (systolic and diastolic) at a point in time';
  static const String systolicBloodPressure = 'Systolic Blood Pressure';
  static const String systolicBloodPressureDescription =
      'Systolic blood pressure measurement at a point in time';
  static const String diastolicBloodPressure = 'Diastolic Blood Pressure';
  static const String diastolicBloodPressureDescription =
      'Diastolic blood pressure measurement at a point in time';
  static const String systolic = 'Systolic';
  static const String systolicBloodPressureValue =
      'Systolic Blood Pressure (mmHg)';
  static const String diastolic = 'Diastolic';
  static const String diastolicBloodPressureValue =
      'Diastolic Blood Pressure (mmHg)';
  static const String bodyPosition = 'Body Position';
  static const String bodyPositionSittingDown = 'Sitting Down';
  static const String bodyPositionStandingUp = 'Standing Up';
  static const String bodyPositionLyingDown = 'Lying Down';
  static const String bodyPositionReclining = 'Reclining';
  static const String oxygenSaturation = 'Oxygen Saturation';
  static const String oxygenSaturationDescription =
      'Oxygen saturation measurement at a point in time';
  static const String oxygenSaturationValue = 'Oxygen Saturation (%)';
  static const String respiratoryRate = 'Respiratory Rate';
  static const String respiratoryRateDescription =
      'Respiratory rate measurement at a point in time';
  static const String respiratoryRateValue = 'Respiratory Rate (breaths/min)';
  static const String vo2Max = 'VO2 Max';
  static const String vo2MaxDescription =
      'Maximal oxygen consumption measured during incremental exercise';
  static const String vo2MaxValue = 'VO2 Max (mL/kg/min)';
  static const String vo2MaxTestType = 'Test Type';

  static const String measurementLocation = 'Measurement Location';
  static const String measurementLocationLeftWrist = 'Left Wrist';
  static const String measurementLocationRightWrist = 'Right Wrist';
  static const String measurementLocationLeftUpperArm = 'Left Upper Arm';
  static const String measurementLocationRightUpperArm = 'Right Upper Arm';
  static const String heartRate = 'Heart Rate';
  static const String heartRateRecordDescription =
      'Single heart rate measurement at a point in time';
  static const String heartRateSeriesRecordDescription =
      'Series of heart rate measurements over a time interval';
  static const String heartRateValue = 'Heart Rate (BPM)';
  static const String heartRateBpm = 'Heart Rate (BPM)';
  static const String heartRateLabel = 'BPM';
  static const String restingHeartRate = 'Resting Heart Rate';
  static const String restingHeartRateDescription =
      'Resting heart rate measurement at a point in time';
  static const String restingHeartRateValue = 'Resting Heart Rate (BPM)';
  static const String heartRateSamples = 'Heart Rate Samples';
  static const String addSample = 'Add Sample';
  static const String removeSample = 'Remove Sample';
  static const String sampleTime = 'Sample Time';
  static const String sampleBpm = 'Sample BPM';
  static const String atLeastOneSampleRequired =
      'At least one sample is required';
  static const String sampleTimeMustBeWithinRange =
      'Sample time must be within start and end time range';
  static const String averageBpm = 'Average BPM';
  static const String minBpm = 'Min BPM';
  static const String maxBpm = 'Max BPM';
  static const String sleepSession = 'Sleep Session';
  static const String sleepSessionDescription =
      'Sleep session with multiple sleep stages over a time interval';
  static const String sleepStageRecord = 'Sleep Stage';
  static const String sleepStageRecordDescription =
      'Single sleep stage measurement over a time interval';
  static const String sleepStages = 'Sleep Stages';
  static const String sleepStage = 'Sleep Stage';
  static const String stageType = 'Stage Type';
  static const String addSleepStage = 'Add Sleep Stage';
  static const String removeSleepStage = 'Remove Sleep Stage';
  static const String atLeastOneSleepStageRequired =
      'At least one sleep stage is required';

  // ==========================================================================
  // Device Types
  // ==========================================================================
  static const String deviceType = 'Device Type';
  static const String phone = 'Phone';
  static const String watch = 'Watch';
  static const String fitnessBand = 'Fitness Band';
  static const String ring = 'Ring';
  static const String scale = 'Scale';
  static const String chestStrap = 'Chest Strap';
  static const String headMounted = 'Head Mounted';
  static const String smartDisplay = 'Smart Display';

  // ==========================================================================
  // Recording Methods
  // ==========================================================================
  static const String manualEntry = 'Manual Entry';
  static const String automaticallyRecorded = 'Automatically Recorded';
  static const String activelyRecorded = 'Actively Recorded';

  // ==========================================================================
  // Measurement Units
  // ==========================================================================
  static const String mass = 'Mass';
  static const String numeric = 'Numeric';
  static const String percentage = 'Percentage';
  static const String length = 'Length';
  static const String bloodGlucose = 'Blood Glucose';
  static const String power = 'Power';
  static const String pressure = 'Pressure';
  static const String temperature = 'Temperature';
  static const String velocity = 'Velocity';
  static const String volume = 'Volume';

  // ==========================================================================
  // Aggregation Metrics
  // ==========================================================================
  static const String aggregationMetric = 'Aggregation Metric';
  static const String aggregate = 'Aggregate';
  static const String sum = 'Sum';
  static const String average = 'Average';
  static const String minimum = 'Minimum';
  static const String maximum = 'Maximum';
  static const String timeRange = 'Time Range';
  static const String aggregationResult = 'Aggregation Result';

  // ==========================================================================
  // Permissions
  // ==========================================================================
  static const String permissions = 'Permissions';
  static const String read = 'Read';
  static const String write = 'Write';
  static const String requestPermissions = 'Request Permissions';
  static const String requestPermissionsTitle = requestPermissions;
  static const String requestSelectedPermissions =
      'Request Selected Permissions';
  static const String dataTypePermissions = 'Data Type Permissions';
  static const String featurePermissions = 'Feature Permissions';
  static const String feature = 'Feature';
  static const String readHealthDataInBackground =
      'Read Health Data in Background';
  static const String readHealthDataHistory = 'Read Health Data History';
  static const String stepsRead = 'Steps - Read';
  static const String stepsWrite = 'Steps - Write';
  static const String weightRead = 'Weight - Read';
  static const String weightWrite = 'Weight - Write';
  static const String distanceRead = 'Distance - Read';
  static const String distanceWrite = 'Distance - Write';
  static const String activeCaloriesBurnedRead =
      'Active Calories Burned - Read';
  static const String activeCaloriesBurnedWrite =
      'Active Calories Burned - Write';
  static const String floorsClimbedRead = 'Floors Climbed - Read';
  static const String floorsClimbedWrite = 'Floors Climbed - Write';
  static const String wheelchairPushesRead = 'Wheelchair Pushes - Read';
  static const String wheelchairPushesWrite = 'Wheelchair Pushes - Write';
  static const String heightRead = 'Height - Read';
  static const String heightWrite = 'Height - Write';
  static const String bodyFatPercentageRead = 'Body Fat Percentage - Read';
  static const String bodyFatPercentageWrite = 'Body Fat Percentage - Write';
  static const String leanBodyMassRead = 'Lean Body Mass - Read';
  static const String leanBodyMassWrite = 'Lean Body Mass - Write';
  static const String bodyTemperatureRead = 'Body Temperature - Read';
  static const String bodyTemperatureWrite = 'Body Temperature - Write';
  static const String hydrationRead = 'Hydration - Read';
  static const String hydrationWrite = 'Hydration - Write';
  static const String heartRateRecordRead = 'Heart Rate - Read';
  static const String heartRateRecordWrite = 'Heart Rate - Write';
  static const String restingHeartRateRecordRead = 'Resting Heart Rate - Read';
  static const String restingHeartRateRecordWrite =
      'Resting Heart Rate - Write';
  static const String iosReadPermissionUnknownStatusNote =
      'Note: On iOS, read permissions may show as "unknown" status even after '
      'being granted due to privacy restrictions. '
      'This is a platform limitation.';

  // ==========================================================================
  // Common Success Messages
  // ==========================================================================
  static const String successfullyWroteRecord =
      'Successfully wrote record with ID';
  static const String recordDeletedSuccessfully = 'Record deleted successfully';
  static const String successfullyDeletedRecords = 'Successfully deleted';
  static const String requestCompleted = 'Request completed';

  // ==========================================================================
  // Common Error Messages
  // ==========================================================================
  static const String errorPrefixColon = 'Error';
  static const String failedToLoadNextPage = 'Failed to load next page';
  static const String failedToRequestPermissions =
      'Failed to request permissions';
  static const String failedToLoadFeatureStatuses =
      'Failed to load feature statuses';

  // ==========================================================================
  // Permission Error Messages
  // ==========================================================================
  static const String readPermissionDenied =
      'Read permission denied or not supported. Please grant read permission.';
  static const String writePermissionDeniedSteps =
      'Write permission denied or not supported. '
      'Please grant write permission for steps.';
  static const String writePermissionDeniedWeight =
      'Write permission denied or not supported. '
      'Please grant write permission for weight.';
  static const String writePermissionDeniedDistance =
      'Write permission denied or not supported. '
      'Please grant write permission for distance.';
  static const String writePermissionDeniedActiveCaloriesBurned =
      'Write permission denied or not supported. '
      'Please grant write permission for active calories burned.';
  static const String writePermissionDeniedFloorsClimbed =
      'Write permission denied or not supported. '
      'Please grant write permission for floors climbed.';
  static const String writePermissionDeniedWheelchairPushes =
      'Write permission denied or not supported. '
      'Please grant write permission for wheelchair pushes.';
  static const String writePermissionDeniedHeight =
      'Write permission denied or not supported. '
      'Please grant write permission for height.';
  static const String writePermissionDeniedBodyFatPercentage =
      'Write permission denied or not supported. '
      'Please grant write permission for body fat percentage.';
  static const String writePermissionDeniedLeanBodyMass =
      'Write permission denied or not supported. '
      'Please grant write permission for lean body mass.';
  static const String writePermissionDeniedBodyTemperature =
      'Write permission denied or not supported. '
      'Please grant write permission for body temperature.';
  static const String writePermissionDeniedHydration =
      'Write permission denied or not supported. '
      'Please grant write permission for hydration.';
  static const String writePermissionDeniedHeartRateRecord =
      'Write permission denied or not supported. '
      'Please grant write permission for heart rate.';
  static const String writePermissionDeniedRestingHeartRateRecord =
      'Write permission denied or not supported. '
      'Please grant write permission for resting heart rate.';
  static const String writePermissionDeniedSleepSession =
      'Write permission denied or not supported. '
      'Please grant write permission for sleep session.';
  static const String writePermissionDeniedSleepStageRecord =
      'Write permission denied or not supported. '
      'Please grant write permission for sleep stage.';
  static const String writePermissionDeniedBloodPressure =
      'Write permission denied or not supported. '
      'Please grant write permission for blood pressure.';
  static const String writePermissionDeniedSystolicBloodPressure =
      'Write permission denied or not supported. '
      'Please grant write permission for systolic blood pressure.';
  static const String writePermissionDeniedDiastolicBloodPressure =
      'Write permission denied or not supported. '
      'Please grant write permission for diastolic blood pressure.';
  static const String writePermissionDeniedOxygenSaturation =
      'Write permission denied or not supported. '
      'Please grant write permission for oxygen saturation.';

  static const String writePermissionDeniedRespiratoryRate =
      'Write permission denied or not supported. '
      'Please grant write permission for respiratory rate.';
  static const String writePermissionDeniedVo2Max =
      'Write permission denied or not supported. '
      'Please grant write permission for VO2 Max.';

  // ==========================================================================
  // Validation Messages
  // ==========================================================================
  static const String pleaseSelectBothStartAndEndDateTime =
      'Please select both start and end date/time';
  static const String pleaseSelectDateTime = 'Please select a date and time';
  static const String pleaseSelectDataType = 'Please select a data type';
  static const String pleaseSelectMetric = 'Please select a metric';
  static const String pleaseSelectDeviceType = 'Please select a device type';
  static const String pleaseSelectRecordingMethod =
      'Please select a recoding method';
  static const String pleaseSelectAtLeastOnePermission =
      'Please select at least one permission';
  static const String pleaseEnterStepCount = 'Please enter step count';
  static const String pleaseEnterWeight = 'Please enter weight';
  static const String pleaseEnterDistance = 'Please enter distance';
  static const String pleaseEnterActiveCaloriesBurned =
      'Please enter active calories burned';
  static const String pleaseEnterFloorsClimbed = 'Please enter floors climbed';
  static const String pleaseEnterWheelchairPushes =
      'Please enter wheelchair pushes';
  static const String pleaseEnterHeight = 'Please enter height';
  static const String pleaseEnterBodyFatPercentage =
      'Please enter body fat percentage';
  static const String pleaseEnterLeanBodyMass = 'Please enter lean body mass';
  static const String pleaseEnterBodyTemperature =
      'Please enter body temperature';
  static const String pleaseEnterHydration = 'Please enter hydration';
  static const String pleaseEnterHeartRate = 'Please enter heart rate (BPM)';
  static const String pleaseEnterSystolicBloodPressure =
      'Please enter systolic blood pressure';
  static const String pleaseEnterDiastolicBloodPressure =
      'Please enter diastolic blood pressure';
  static const String pleaseEnterValidNumber = 'Please enter a valid number';
  static const String endTimeMustBeAfterStartTime =
      'End time must be after start time';
  static const String countMustBeNonNegative = 'Count must be non-negative';
  static const String weightMustBeGreaterThanZero =
      'Weight must be greater than 0';
  static const String distanceMustBeGreaterThanZero =
      'Distance must be greater than 0';
  static const String heightMustBeGreaterThanZero =
      'Height must be greater than 0';
  static const String bodyFatPercentageMustBeBetween0And100 =
      'Body fat percentage must be between 0 and 100';
  static const String leanBodyMassMustBeGreaterThanZero =
      'Lean body mass must be greater than 0';
  static const String bodyTemperatureMustBeValid =
      'Body temperature must be a valid value';
  static const String activeCaloriesBurnedMustBeGreaterThanZero =
      'Active calories burned must be greater than 0';
  static const String floorsClimbedMustBeNonNegative =
      'Floors climbed must be non-negative';
  static const String wheelchairPushesMustBeNonNegative =
      'Wheelchair pushes must be non-negative';
  static const String hydrationMustBeGreaterThanZero =
      'Hydration must be greater than 0';
  static const String heartRateMustBePositive =
      'Heart rate must be a positive number';
  static const String heartRateMustBeValidBpm =
      'Heart rate must be a valid BPM value (typically 30-220)';
  static const String pageSizeMustBeBetween1And10000 =
      'Page size must be between 1 and 10000';
  static const String systolicBloodPressureMustBeGreaterThanZero =
      'Systolic blood pressure must be greater than 0';
  static const String diastolicBloodPressureMustBeGreaterThanZero =
      'Diastolic blood pressure must be greater than 0';
  static const String pleaseEnterOxygenSaturation =
      'Please enter oxygen saturation';
  static const String oxygenSaturationMustBeBetween0And100 =
      'Oxygen saturation must be between 0 and 100';

  static const String pleaseEnterRespiratoryRate =
      'Please enter respiratory rate';
  static const String respiratoryRateMustBePositive =
      'Respiratory rate must be a positive number';
  static const String pleaseEnterVo2Max = 'Please enter VO2 Max';
  static const String vo2MaxMustBePositive =
      'VO2 Max must be a positive number';
  static const String vo2MaxMustBeValid = 'VO2 Max must be a valid number';

  // ==========================================================================
  // Page Titles and Actions
  // ==========================================================================
  static const String insertHealthRecord = 'Insert Health Record';
  static const String insertSteps = 'Insert Steps';
  static const String insertWeight = 'Insert Weight';
  static const String insertHeight = 'Insert Height';
  static const String insertBodyFatPercentage = 'Insert Body Fat Percentage';
  static const String insertLeanBodyMass = 'Insert Lean Body Mass';
  static const String insertBodyTemperature = 'Insert Body Temperature';
  static const String insertDistance = 'Insert Distance';
  static const String insertActiveCaloriesBurned =
      'Insert Active Calories Burned';
  static const String insertFloorsClimbed = 'Insert Floors Climbed';
  static const String insertWheelchairPushes = 'Insert Wheelchair Pushes';
  static const String insertHydration = 'Insert Hydration';
  static const String insertHeartRateRecord = 'Insert Heart Rate';
  static const String insertRestingHeartRateRecord =
      'Insert Resting Heart Rate';
  static const String insertSleepSession = 'Insert Sleep Session';
  static const String insertSleepStageRecord = 'Insert Sleep Stage';
  static const String insertBloodPressure = 'Insert Blood Pressure';
  static const String insertSystolicBloodPressure =
      'Insert Systolic Blood Pressure';
  static const String insertDiastolicBloodPressure =
      'Insert Diastolic Blood Pressure';
  static const String insertOxygenSaturation = 'Insert Oxygen Saturation';
  static const String insertRespiratoryRate = 'Insert Respiratory Rate';
  static const String insertVo2Max = 'Insert VO2 Max';

  static const String readHealthRecords = 'Read Health Records';
  static const String readAggregateData = 'Read Aggregate Data';

  // ==========================================================================
  // Page Actions
  // ==========================================================================
  static const String readRecords = 'Read Records';
  static const String writeRecords = 'Write Records';
  static const String loadMore = 'Load More';

  // ==========================================================================
  // Record Display
  // ==========================================================================
  static const String recordDetails = 'Record Details';
  static const String unknownRecordType = 'Unknown Record Type';
  static const String startLabel = 'Start';
  static const String endLabel = 'End';
  static const String records = 'record(s)';
  static const String foundRecords = 'Found';
  static const String moreAvailable = 'More available';
  static const String noRecordsFound = 'No records found';
  static const String pageSize =
      'Page Size (1-${HealthConnectorConfigConstants.maxPageSize})';

  // ==========================================================================
  // Health Record Detail Fields
  // ==========================================================================
  static const String startZoneOffsetSeconds = 'Start Zone Offset (sec)';
  static const String endZoneOffsetSeconds = 'End Zone Offset (sec)';
  static const String zoneOffsetSeconds = 'Zone Offset (sec)';

  // ==========================================================================
  // Health Record Metadata
  // ==========================================================================
  static const String metadata = 'Metadata';
  static const String dataOrigin = 'Data Origin';
  static const String lastModified = 'Last Modified';
  static const String clientRecordId = 'Client Record ID';
  static const String clientRecordVersion = 'Client Record Version';
  static const String manufacturer = 'Manufacturer';
  static const String model = 'Model';
  static const String hardwareVersion = 'Hardware Version';
  static const String firmwareVersion = 'Firmware Version';
  static const String softwareVersion = 'Software Version';
  static const String localIdentifier = 'Local Identifier';
  static const String udiDeviceId = 'UDI Device ID';

  // ==========================================================================
  // Sleep Stage Types
  // ==========================================================================
  static const String sleepStageUnknown = 'Unknown';
  static const String sleepStageAwake = 'Awake';
  static const String sleepStageSleeping = 'Sleeping';
  static const String sleepStageOutOfBed = 'Out of Bed';
  static const String sleepStageLight = 'Light';
  static const String sleepStageDeep = 'Deep';
  static const String sleepStageRem = 'REM';
  static const String sleepStageInBed = 'In Bed';

  // ==========================================================================
  // Meal Types
  // ==========================================================================
  static const String mealType = 'Meal Type';
  static const String mealTypeUnknown = 'Unknown';
  static const String mealTypeBreakfast = 'Breakfast';
  static const String mealTypeLunch = 'Lunch';
  static const String mealTypeDinner = 'Dinner';
  static const String mealTypeSnack = 'Snack';
  static const String foodName = 'Food Name';
  static const String food = 'Food';
  static const String meal = 'Meal';

  // ==========================================================================
  // Nutrient Data Types
  // ==========================================================================
  static const String nutrition = 'Nutrition';
  static const String nutritionDescription =
      'Complete nutrition record with multiple nutrients';
  static const String nutritionRecord = 'Nutrition Record';
  static const String nutrients = 'nutrients';
  static const String energy = 'Energy';
  static const String energyDescription = 'Energy (calorie) intake';
  static const String energyKcal = 'Energy (kcal)';
  static const String energyCal = 'Energy (cal)';
  static const String energyValue = 'Energy (kcal)';
  static const String caffeine = 'Caffeine';
  static const String caffeineDescription = 'Caffeine intake';
  static const String caffeineG = 'Caffeine (g)';
  static const String caffeineMg = 'Caffeine (mg)';
  static const String protein = 'Protein';
  static const String proteinDescription = 'Protein intake';
  static const String proteinG = 'Protein (g)';
  static const String totalCarbohydrate = 'Total Carbohydrate';
  static const String totalCarbohydrateDescription =
      'Total carbohydrate intake';
  static const String totalCarbohydrateG = 'Total Carbohydrate (g)';
  static const String totalFat = 'Total Fat';
  static const String totalFatDescription = 'Total fat intake';
  static const String totalFatG = 'Total Fat (g)';
  static const String saturatedFat = 'Saturated Fat';
  static const String saturatedFatDescription = 'Saturated fat intake';
  static const String saturatedFatG = 'Saturated Fat (g)';
  static const String monounsaturatedFat = 'Monounsaturated Fat';
  static const String monounsaturatedFatDescription =
      'Monounsaturated fat intake';
  static const String monounsaturatedFatG = 'Monounsaturated Fat (g)';
  static const String polyunsaturatedFat = 'Polyunsaturated Fat';
  static const String polyunsaturatedFatDescription =
      'Polyunsaturated fat intake';
  static const String polyunsaturatedFatG = 'Polyunsaturated Fat (g)';
  static const String cholesterol = 'Cholesterol';
  static const String cholesterolDescription = 'Cholesterol intake';
  static const String cholesterolG = 'Cholesterol (g)';
  static const String dietaryFiber = 'Dietary Fiber';
  static const String dietaryFiberDescription = 'Dietary fiber intake';
  static const String dietaryFiberG = 'Dietary Fiber (g)';
  static const String sugar = 'Sugar';
  static const String sugarDescription = 'Sugar intake';
  static const String sugarG = 'Sugar (g)';
  static const String calcium = 'Calcium';
  static const String calciumDescription = 'Calcium intake';
  static const String calciumG = 'Calcium (g)';
  static const String iron = 'Iron';
  static const String ironDescription = 'Iron intake';
  static const String ironG = 'Iron (g)';
  static const String magnesium = 'Magnesium';
  static const String magnesiumDescription = 'Magnesium intake';
  static const String magnesiumG = 'Magnesium (g)';
  static const String manganese = 'Manganese';
  static const String manganeseDescription = 'Manganese intake';
  static const String manganeseG = 'Manganese (g)';
  static const String phosphorus = 'Phosphorus';
  static const String phosphorusDescription = 'Phosphorus intake';
  static const String phosphorusG = 'Phosphorus (g)';
  static const String potassium = 'Potassium';
  static const String potassiumDescription = 'Potassium intake';
  static const String potassiumG = 'Potassium (g)';
  static const String selenium = 'Selenium';
  static const String seleniumDescription = 'Selenium intake';
  static const String seleniumG = 'Selenium (g)';
  static const String sodium = 'Sodium';
  static const String sodiumDescription = 'Sodium intake';
  static const String sodiumG = 'Sodium (g)';
  static const String zinc = 'Zinc';
  static const String zincDescription = 'Zinc intake';
  static const String zincG = 'Zinc (g)';
  static const String vitaminA = 'Vitamin A';
  static const String vitaminADescription = 'Vitamin A intake';
  static const String vitaminAG = 'Vitamin A (g)';
  static const String vitaminB6 = 'Vitamin B6';
  static const String vitaminB6Description = 'Vitamin B6 intake';
  static const String vitaminB6G = 'Vitamin B6 (g)';
  static const String vitaminB12 = 'Vitamin B12';
  static const String vitaminB12Description = 'Vitamin B12 intake';
  static const String vitaminB12G = 'Vitamin B12 (g)';
  static const String vitaminC = 'Vitamin C';
  static const String vitaminCDescription = 'Vitamin C intake';
  static const String vitaminCG = 'Vitamin C (g)';
  static const String vitaminD = 'Vitamin D';
  static const String vitaminDDescription = 'Vitamin D intake';
  static const String vitaminDG = 'Vitamin D (g)';
  static const String vitaminE = 'Vitamin E';
  static const String vitaminEDescription = 'Vitamin E intake';
  static const String vitaminEG = 'Vitamin E (g)';
  static const String vitaminK = 'Vitamin K';
  static const String vitaminKDescription = 'Vitamin K intake';
  static const String vitaminKG = 'Vitamin K (g)';
  static const String thiamin = 'Thiamin';
  static const String thiaminDescription = 'Thiamin intake';
  static const String thiaminG = 'Thiamin (g)';
  static const String riboflavin = 'Riboflavin';
  static const String riboflavinDescription = 'Riboflavin intake';
  static const String riboflavinG = 'Riboflavin (g)';
  static const String niacin = 'Niacin';
  static const String niacinDescription = 'Niacin intake';
  static const String niacinG = 'Niacin (g)';
  static const String folate = 'Folate';
  static const String folateDescription = 'Folate intake';
  static const String folateG = 'Folate (g)';
  static const String biotin = 'Biotin';
  static const String biotinDescription = 'Biotin intake';
  static const String biotinG = 'Biotin (g)';
  static const String pantothenicAcid = 'Pantothenic Acid';
  static const String pantothenicAcidDescription = 'Pantothenic acid intake';
  static const String pantothenicAcidG = 'Pantothenic Acid (g)';

  // ==========================================================================
  // Nutrient Validation Messages
  // ==========================================================================
  static const String pleaseEnterEnergy = 'Please enter energy';
  static const String pleaseEnterCaffeine = 'Please enter caffeine';
  static const String pleaseEnterProtein = 'Please enter protein';
  static const String pleaseEnterTotalCarbohydrate =
      'Please enter total carbohydrate';
  static const String pleaseEnterTotalFat = 'Please enter total fat';
  static const String pleaseEnterSaturatedFat = 'Please enter saturated fat';
  static const String pleaseEnterMonounsaturatedFat =
      'Please enter monounsaturated fat';
  static const String pleaseEnterPolyunsaturatedFat =
      'Please enter polyunsaturated fat';
  static const String pleaseEnterCholesterol = 'Please enter cholesterol';
  static const String pleaseEnterDietaryFiber = 'Please enter dietary fiber';
  static const String pleaseEnterSugar = 'Please enter sugar';
  static const String pleaseEnterCalcium = 'Please enter calcium';
  static const String pleaseEnterIron = 'Please enter iron';
  static const String pleaseEnterMagnesium = 'Please enter magnesium';
  static const String pleaseEnterManganese = 'Please enter manganese';
  static const String pleaseEnterPhosphorus = 'Please enter phosphorus';
  static const String pleaseEnterPotassium = 'Please enter potassium';
  static const String pleaseEnterSelenium = 'Please enter selenium';
  static const String pleaseEnterSodium = 'Please enter sodium';
  static const String pleaseEnterZinc = 'Please enter zinc';
  static const String pleaseEnterVitaminA = 'Please enter vitamin A';
  static const String pleaseEnterVitaminB6 = 'Please enter vitamin B6';
  static const String pleaseEnterVitaminB12 = 'Please enter vitamin B12';
  static const String pleaseEnterVitaminC = 'Please enter vitamin C';
  static const String pleaseEnterVitaminD = 'Please enter vitamin D';
  static const String pleaseEnterVitaminE = 'Please enter vitamin E';
  static const String pleaseEnterVitaminK = 'Please enter vitamin K';
  static const String pleaseEnterThiamin = 'Please enter thiamin';
  static const String pleaseEnterRiboflavin = 'Please enter riboflavin';
  static const String pleaseEnterNiacin = 'Please enter niacin';
  static const String pleaseEnterFolate = 'Please enter folate';
  static const String pleaseEnterBiotin = 'Please enter biotin';
  static const String pleaseEnterPantothenicAcid =
      'Please enter pantothenic acid';

  // ==========================================================================
  // Nutrient Write Permission Error Messages
  // ==========================================================================
  static const String writePermissionDeniedEnergyNutrient =
      'Write permission denied for energy nutrient';
  static const String writePermissionDeniedCaffeine =
      'Write permission denied for caffeine';
  static const String writePermissionDeniedProtein =
      'Write permission denied for protein';
  static const String writePermissionDeniedTotalCarbohydrate =
      'Write permission denied for total carbohydrate';
  static const String writePermissionDeniedTotalFat =
      'Write permission denied for total fat';
  static const String writePermissionDeniedSaturatedFat =
      'Write permission denied for saturated fat';
  static const String writePermissionDeniedMonounsaturatedFat =
      'Write permission denied for monounsaturated fat';
  static const String writePermissionDeniedPolyunsaturatedFat =
      'Write permission denied for polyunsaturated fat';
  static const String writePermissionDeniedCholesterol =
      'Write permission denied for cholesterol';
  static const String writePermissionDeniedDietaryFiber =
      'Write permission denied for dietary fiber';
  static const String writePermissionDeniedSugar =
      'Write permission denied for sugar';
  static const String writePermissionDeniedCalcium =
      'Write permission denied for calcium';
  static const String writePermissionDeniedIron =
      'Write permission denied for iron';
  static const String writePermissionDeniedMagnesium =
      'Write permission denied for magnesium';
  static const String writePermissionDeniedManganese =
      'Write permission denied for manganese';
  static const String writePermissionDeniedPhosphorus =
      'Write permission denied for phosphorus';
  static const String writePermissionDeniedPotassium =
      'Write permission denied for potassium';
  static const String writePermissionDeniedSelenium =
      'Write permission denied for selenium';
  static const String writePermissionDeniedSodium =
      'Write permission denied for sodium';
  static const String writePermissionDeniedZinc =
      'Write permission denied for zinc';
  static const String writePermissionDeniedVitaminA =
      'Write permission denied for vitamin A';
  static const String writePermissionDeniedVitaminB6 =
      'Write permission denied for vitamin B6';
  static const String writePermissionDeniedVitaminB12 =
      'Write permission denied for vitamin B12';
  static const String writePermissionDeniedVitaminC =
      'Write permission denied for vitamin C';
  static const String writePermissionDeniedVitaminD =
      'Write permission denied for vitamin D';
  static const String writePermissionDeniedVitaminE =
      'Write permission denied for vitamin E';
  static const String writePermissionDeniedVitaminK =
      'Write permission denied for vitamin K';
  static const String writePermissionDeniedThiamin =
      'Write permission denied for thiamin';
  static const String writePermissionDeniedRiboflavin =
      'Write permission denied for riboflavin';
  static const String writePermissionDeniedNiacin =
      'Write permission denied for niacin';
  static const String writePermissionDeniedFolate =
      'Write permission denied for folate';
  static const String writePermissionDeniedBiotin =
      'Write permission denied for biotin';
  static const String writePermissionDeniedPantothenicAcid =
      'Write permission denied for pantothenic acid';
  static const String writePermissionDeniedNutrition =
      'Write permission denied for nutrition';

  // ==========================================================================
  // Nutrient Page Titles
  // ==========================================================================
  static const String insertEnergy = 'Insert Energy';
  static const String insertCaffeine = 'Insert Caffeine';
  static const String insertProtein = 'Insert Protein';
  static const String insertTotalCarbohydrate = 'Insert Total Carbohydrate';
  static const String insertTotalFat = 'Insert Total Fat';
  static const String insertSaturatedFat = 'Insert Saturated Fat';
  static const String insertMonounsaturatedFat = 'Insert Monounsaturated Fat';
  static const String insertPolyunsaturatedFat = 'Insert Polyunsaturated Fat';
  static const String insertCholesterol = 'Insert Cholesterol';
  static const String insertDietaryFiber = 'Insert Dietary Fiber';
  static const String insertSugar = 'Insert Sugar';
  static const String insertCalcium = 'Insert Calcium';
  static const String insertIron = 'Insert Iron';
  static const String insertMagnesium = 'Insert Magnesium';
  static const String insertManganese = 'Insert Manganese';
  static const String insertPhosphorus = 'Insert Phosphorus';
  static const String insertPotassium = 'Insert Potassium';
  static const String insertSelenium = 'Insert Selenium';
  static const String insertSodium = 'Insert Sodium';
  static const String insertZinc = 'Insert Zinc';
  static const String insertVitaminA = 'Insert Vitamin A';
  static const String insertVitaminB6 = 'Insert Vitamin B6';
  static const String insertVitaminB12 = 'Insert Vitamin B12';
  static const String insertVitaminC = 'Insert Vitamin C';
  static const String insertVitaminD = 'Insert Vitamin D';
  static const String insertVitaminE = 'Insert Vitamin E';
  static const String insertVitaminK = 'Insert Vitamin K';
  static const String insertThiamin = 'Insert Thiamin';
  static const String insertRiboflavin = 'Insert Riboflavin';
  static const String insertNiacin = 'Insert Niacin';
  static const String insertFolate = 'Insert Folate';
  static const String insertBiotin = 'Insert Biotin';
  static const String insertPantothenicAcid = 'Insert Pantothenic Acid';
  static const String insertNutrition = 'Insert Nutrition';

  // ==========================================================================
  // Nutrition Form Field Labels
  // ==========================================================================
  static const String foodNameOptional = 'Food Name (optional)';
  static const String foodNameOptionalHelper = 'Optional name of the food item';
  static const String nutrientsAllOptional = 'Nutrients (all optional)';
  static const String energyAndMacronutrients = 'Energy & Macronutrients';
  static const String vitamins = 'Vitamins';
  static const String minerals = 'Minerals';
  static const String other = 'Other';
  static const String energyKcalOptional = 'Energy (kcal, optional)';
  static const String energyKcalHelper = 'Enter energy in kilocalories';
  static const String fieldOptionalHelper = 'Enter value in';
  static const String fieldOptional = '(optional)';
  static const String breathsPerMinute = 'breaths/min';
}
