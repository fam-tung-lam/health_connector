import 'package:health_connector/health_connector_internal.dart';

/// Centralized collection of all text strings used throughout the application.
///
/// This class provides a single source of truth for all UI text, making it
/// easier to maintain, localize, and update text content.
abstract final class AppTexts {
  // region App Titles
  static const String healthConnectorToolbox = 'Health Connector Toolbox';
  static const String welcomeToToolbox = 'Welcome to Health Connector Toolbox';
  static const String toolboxSubtitle =
      'Cross-platform health data SDK demo application';

  // endregion

  // region Home Page
  static const String platformStatus = 'Platform Status';
  static const String ready = 'Ready';
  static const String healthMetrics = 'Health Metrics';
  static const String quickActions = 'Quick Actions';
  static const String exploreFeatures = 'Explore Features';

  // Feature Descriptions
  static const String openHealthAppStore = 'Open Health App Store';
  static const String openHealthAppStoreDescription =
      'Install or update the health app from the app store';
  static const String permissionsDescription =
      'Manage health data permissions and access controls';
  static const String readRecordsDescription =
      'Browse and query health records from connected platforms';
  static const String writeRecordsDescription =
      'Write new health data records to the platform';
  static const String aggregateDescription =
      'Perform aggregation operations on health data';

  // Demo Health Metrics
  static const String todaySteps = "Today's Steps";
  static const String currentHeartRate = 'Heart Rate';
  static const String lastNightSleep = 'Last Night';

  // endregion

  // region Permissions Page
  static const String permissionSummary = 'Permission Summary';
  static const String total = 'Total';
  static const String of = 'of';

  // endregion

  // region Aggregate Page
  static const String selectDataType = 'Select Data Type';
  static const String aggregationSettings = 'Aggregation Settings';
  static const String timePeriod = 'Time Period';
  static const String selectOptionsAndAggregate =
      'Select your options and tap calculate to see aggregation results';

  // Metric descriptions
  static const String sumDescription = 'Total sum of all values';
  static const String averageDescription = 'Average of all values';
  static const String minDescription = 'Minimum value found';
  static const String maxDescription = 'Maximum value found';
  static const String countDescription = 'Number of records';

  // endregion

  // region Read Records Page
  static const String selectData = 'Select Data';
  static const String displayOptions = 'Display Options';
  static const String recordsSummary = 'Records Summary';
  static const String totalRecords = 'Total Records';
  static const String sortOrder = 'Sort Order';
  static const String timeAscending = 'Time Ascending';
  static const String timeDescending = 'Time Descending';

  // endregion

  // region Date Range Presets
  static const String lastHour = 'Last Hour';
  static const String today = 'Today';
  static const String last7Days = 'Last 7 Days';
  static const String last30Days = 'Last 30 Days';

  // endregion

  /// Returns the localized label for a given [HealthDataType].
  static String getLabel(HealthDataType type) {
    return switch (type) {
      StepsDataType() => steps,
      WeightDataType() => weight,
      HeightDataType() => height,
      BodyFatPercentageDataType() => bodyFatPercentage,
      LeanBodyMassDataType() => leanBodyMass,
      BodyTemperatureDataType() => bodyTemperature,
      BasalBodyTemperatureDataType() => basalBodyTemperature,
      CervicalMucusDataType() => cervicalMucus,
      BloodPressureDataType() => bloodPressure,
      SystolicBloodPressureDataType() => systolic,
      DiastolicBloodPressureDataType() => diastolic,
      DistanceDataType() ||
      CrossCountrySkiingDistanceDataType() ||
      CyclingDistanceDataType() ||
      DownhillSnowSportsDistanceDataType() ||
      PaddleSportsDistanceDataType() ||
      RowingDistanceDataType() ||
      SixMinuteWalkTestDistanceDataType() ||
      SkatingSportsDistanceDataType() ||
      SwimmingDistanceDataType() ||
      WheelchairDistanceDataType() ||
      WalkingRunningDistanceDataType() => distance,
      ActiveEnergyBurnedDataType() => activeEnergyBurned,
      BasalEnergyBurnedDataType() => basalEnergyBurned,
      TotalEnergyBurnedDataType() => totalEnergyBurned,
      FloorsClimbedDataType() => floorsClimbed,
      WheelchairPushesDataType() => wheelchairPushes,
      HydrationDataType() => hydration,
      HeartRateDataType() || HeartRateSeriesDataType() => heartRate,
      CyclingPedalingCadenceDataType() ||
      CyclingPedalingCadenceSeriesDataType() => cyclingPedalingCadence,
      SleepSessionDataType() => sleepSession,
      SleepStageDataType() => sleepStage,
      SexualActivityDataType() => sexualActivity,
      IntermenstrualBleedingDataType() => intermenstrualBleeding,
      MenstrualFlowDataType() => menstrualFlow,
      MenstrualFlowInstantDataType() => menstrualFlowInstant,
      OvulationTestDataType() => ovulationTest,
      DietaryEnergyConsumedDataType() => energy,
      DietaryCaffeineDataType() => caffeine,
      DietaryProteinDataType() => protein,
      DietaryTotalCarbohydrateDataType() => totalCarbohydrate,
      DietaryTotalFatDataType() => totalFat,
      DietarySaturatedFatDataType() => saturatedFat,
      DietaryMonounsaturatedFatDataType() => monounsaturatedFat,
      DietaryPolyunsaturatedFatDataType() => polyunsaturatedFat,
      DietaryCholesterolDataType() => cholesterol,
      DietaryFiberNutrientDataType() => dietaryFiber,
      DietarySugarDataType() => sugar,
      DietaryCalciumDataType() => calcium,
      DietaryIronDataType() => iron,
      DietaryMagnesiumDataType() => magnesium,
      DietaryManganeseDataType() => manganese,
      DietaryPhosphorusDataType() => phosphorus,
      DietaryPotassiumDataType() => potassium,
      DietarySeleniumDataType() => selenium,
      DietarySodiumDataType() => sodium,
      DietaryZincDataType() => zinc,
      DietaryVitaminADataType() => vitaminA,
      DietaryVitaminB6DataType() => vitaminB6,
      DietaryVitaminB12DataType() => vitaminB12,
      DietaryVitaminCDataType() => vitaminC,
      DietaryVitaminDDataType() => vitaminD,
      DietaryVitaminEDataType() => vitaminE,
      DietaryVitaminKDataType() => vitaminK,
      DietaryThiaminDataType() => thiamin,
      DietaryRiboflavinDataType() => riboflavin,
      DietaryNiacinDataType() => niacin,
      DietaryFolateDataType() => folate,
      DietaryBiotinDataType() => biotin,
      DietaryPantothenicAcidDataType() => pantothenicAcid,
      NutritionDataType() => nutrition,
      RestingHeartRateDataType() => restingHeartRate,
      OxygenSaturationDataType() => oxygenSaturation,
      RespiratoryRateDataType() => respiratoryRate,
      Vo2MaxDataType() => vo2Max,
      BloodGlucoseDataType() => bloodGlucose,
      SpeedSeriesDataType() ||
      WalkingSpeedDataType() ||
      RunningSpeedDataType() ||
      StairAscentSpeedDataType() ||
      StairDescentSpeedDataType() => speed,
      PowerSeriesDataType() => powerSeries,
      CyclingPowerDataType() => cyclingPower,
      ExerciseSessionDataType() => exerciseSession,
      MindfulnessSessionDataType() => mindfulnessSession,
      BoneMassDataType() => boneMass,
      BodyWaterMassDataType() => bodyWaterMass,
      HeartRateVariabilityRMSSDDataType() => heartRateVariabilityRMSSD,
      BodyMassIndexDataType() => bodyMassIndex,
      WaistCircumferenceDataType() => waistCircumference,
      HeartRateVariabilitySDNNDataType() => heartRateVariabilitySDNN,
    };
  }

  /// Returns the "Insert [label]" text.
  static String getInsertText(String label) => '$insert $label';

  /// Returns the "Insert [type]" text for a data type.
  static String getInsertTextFor(HealthDataType type) {
    if (type is SpeedSeriesDataType ||
        type is WalkingSpeedDataType ||
        type is RunningSpeedDataType ||
        type is StairAscentSpeedDataType ||
        type is StairDescentSpeedDataType) {
      return '$insert $speed Data';
    }
    return getInsertText(getLabel(type));
  }

  /// Returns the "Please enter [label]" text.
  ///
  /// Converts the label to lowercase effectively for sentence flow.
  static String getPleaseEnterText(String label) =>
      '$pleaseEnter ${label.toLowerCase()}';

  /// Returns the "Please enter [type]" text for a data type.
  static String getPleaseEnterTextFor(HealthDataType type) =>
      getPleaseEnterText(getLabel(type));

  /// Returns the "Please select [label]" text.
  static String getPleaseSelectText(String label) =>
      '$pleaseSelect ${label.toLowerCase()}';

  /// Returns the "Write Permission not granted for [label]" text.
  static String getWritePermissionDeniedText(String label) =>
      'Write permission denied or not supported. '
      'Please grant write permission for ${label.toLowerCase()}.';

  /// Returns the "Write Permission not granted for [type]" text.
  static String getWritePermissionDeniedTextFor(HealthDataType type) {
    if (type is SpeedSeriesDataType ||
        type is WalkingSpeedDataType ||
        type is RunningSpeedDataType ||
        type is StairAscentSpeedDataType ||
        type is StairDescentSpeedDataType) {
      return 'Write Permission not granted for speed data';
    }
    return getWritePermissionDeniedText(getLabel(type));
  }

  /// Returns the "[label] ([unit])" text.
  static String withUnit(String label, String unit) => '$label ($unit)';

  /// Returns the "[label] Value ([unit])" text.
  static String valueWithUnit(String label, String unit) =>
      '$label $value ($unit)';

  // region Common UI Elements
  static const String tryAgain = 'Try Again';
  static const String pleaseSelect = 'Please select';
  static const String selected = 'selected';
  static const String insert = 'Insert';
  static const String pleaseEnter = 'Please enter';
  static const String delete = 'Delete';
  static const String cancel = 'Cancel';
  static const String deleteRecordQuestion = 'Delete Record?';
  static const String actionCannotBeUndone = 'This action cannot be undone.';
  static const String sample = 'Sample';
  static const String samples = '${sample}s';
  static const String noSamplesAvailable = 'No $samples available yet';
  static const String noSleepStagesAvailable = 'No ${sleepStage}s available';
  static const String samplesCount = '$samples Count';
  static const String unsupportedRecord = 'Unsupported Record';

  // endregion

  // region Common Labels
  static const String id = 'ID';
  static const String status = 'Status';
  static const String time = 'Time';
  static const String date = 'Date';
  static const String startDate = 'Start $date';
  static const String startTime = 'Start $time';
  static const String endDate = 'End $date';
  static const String endTime = 'End $time';
  static const String dataType = 'Data $type';
  static const String value = 'Value';
  static const String valueType = '$value $type';
  static const String metric = 'Metric';
  static const String type = 'Type';
  static const String name = 'Name';
  static const String notes = 'Notes';
  static const String count = 'Count';
  static const String duration = 'Duration';
  static const String durationHHMM = '$duration (HH:MM)';
  static const String deviceLabel = 'Device';
  static const String recording = 'Recording';
  static const String recordingMethod = 'Recording Method';
  static const String search = 'Search...';
  static const String sleepStage = 'Sleep Stage';
  static const String sleepStageType = '$sleepStage $type';

  // endregion

  // region Common Status Values
  static const String unknown = 'Unknown';
  static const String granted = 'granted';
  static const String denied = 'denied';
  static const String available = 'Available';
  static const String unavailable = 'Unavailable';
  static const String notAvailable = 'N/A';
  static const String noDataTypesFound = 'No data types found';

  // endregion

  // region Health Platforms
  static const String appleHealth = 'Apple Health';
  static const String healthConnect = 'Health Connect';

  // endregion

  // region Health Data Types
  static const String steps = 'Steps';
  static const String stepCount = 'Step Count';
  static const String weight = 'Weight';

  // region Health Data Type Categories
  static const String activityCategory = 'Activity';
  static const String bodyMeasurementCategory = 'Body Measurement';
  static const String clinicalCategory = 'Clinical';
  static const String mentalHealthCategory = 'Mental Health';
  static const String mobilityCategory = 'Mobility';
  static const String nutritionCategory = 'Nutrition';
  static const String reproductiveHealthCategory = 'Reproductive Health';
  static const String sleepCategory = 'Sleep';
  static const String vitalsCategory = 'Vitals';

  // endregion

  // Distance activity values
  static const String activeEnergyBurned = 'Active Energy Burned';
  static const String basalEnergyBurned = 'Basal Energy Burned';
  static const String totalEnergyBurned = 'Total Energy Burned';
  static const String crossCountrySkiing = 'Cross Country Skiing';
  static const String cycling = 'Cycling';
  static const String downhillSnowSports = 'Downhill Snow Sports';
  static const String paddleSports = 'Paddle Sports';
  static const String rowing = 'Rowing';
  static const String sixMinuteWalkTest = 'Six Minute Walk Test';
  static const String skatingSports = 'Skating Sports';
  static const String swimming = 'Swimming';
  static const String wheelchair = 'Wheelchair';
  static const String walkingRunning = 'Walking/Running';
  static const String walking = 'Walking';
  static const String running = 'Running';
  static const String stairAscent = 'Stair Ascent';
  static const String stairDescent = 'Stair Descent';
  static const String distance = 'Distance';
  static const String cyclingDistance = '$cycling $distance';
  static const String downhillSnowSportsDistance =
      '$downhillSnowSports $distance';
  static const String paddleSportsDistance = '$paddleSports $distance';
  static const String rowingDistance = '$rowing $distance';
  static const String sixMinuteWalkTestDistance =
      '$sixMinuteWalkTest $distance';
  static const String skatingSportsDistance = '$skatingSports $distance';
  static const String swimmingDistance = '$swimming $distance';
  static const String wheelchairDistance = '$wheelchair $distance';
  static const String walkingRunningDistance = '$walkingRunning $distance';
  static const String floorsClimbed = 'Floors Climbed';
  static const String wheelchairPushes = 'Wheelchair Pushes';
  static const String pushes = 'pushes';
  static const String wheelchairPushesLabel = pushes;
  static const String height = 'Height';
  static const String bodyFatPercentage = 'Body Fat Percentage';
  static const String leanBodyMass = 'Lean Body Mass';
  static const String bodyMassIndex = 'Body Mass Index';
  static const String waistCircumference = 'Waist Circumference';
  static const String bodyTemperature = 'Body Temperature';
  static const String basalBodyTemperature = 'Basal Body Temperature';
  static const String boneMass = 'Bone Mass';
  static const String bodyWaterMass = 'Body Water Mass';
  static const String heartRateVariabilityRMSSD =
      'Heart Rate Variability (RMSSD)';
  static const String heartRateVariabilitySDNN =
      'Heart Rate Variability (SDNN)';
  static const String cervicalMucus = 'Cervical Mucus';
  static const String hydration = 'Hydration';
  static const String bloodPressure = 'Blood Pressure';
  static const String systolic = 'Systolic';
  static const String diastolic = 'Diastolic';
  static const String systolicBloodPressure = '$systolic $bloodPressure';
  static const String diastolicBloodPressure = '$diastolic $bloodPressure';
  static const String bodyPosition = 'Body Position';
  static const String standingUp = 'Standing Up';
  static const String sittingDown = 'Sitting Down';
  static const String lyingDown = 'Lying Down';
  static const String reclining = 'Reclining';
  static const String oxygenSaturation = 'Oxygen Saturation';
  static const String respiratoryRate = 'Respiratory Rate';
  static const String vo2Max = 'VO2 Max';
  static const String vo2MaxTestType = 'Test $type';
  static const String measurementLocation = 'Measurement Location';
  static const String leftWrist = 'Left Wrist';
  static const String rightWrist = 'Right Wrist';
  static const String leftUpperArm = 'Left Upper Arm';
  static const String rightUpperArm = 'Right Upper Arm';
  static const String armpit = 'Armpit';
  static const String ear = 'Ear';
  static const String finger = 'Finger';
  static const String forehead = 'Forehead';
  static const String mouth = 'Mouth';
  static const String rectum = 'Rectum';
  static const String temporalArtery = 'Temporal Artery';
  static const String toe = 'Toe';
  static const String vagina = 'Vagina';
  static const String wrist = 'Wrist';
  static const String heartRate = 'Heart Rate';
  static const String restingHeartRate = 'Resting Heart Rate';
  static const String heartRateSamples = '$heartRate Samples';
  static const String addSample = 'Add Sample';
  static const String removeSample = 'Remove Sample';
  static const String sampleBpm = 'Sample BPM';
  static const String atLeastOneSampleRequired =
      'At least one sample is required';
  static const String sleepSession = 'Sleep Session';
  static const String sleepStages = '${sleepStage}s';
  static const String stageType = 'Stage $type';
  static const String bloodPressureType = '$bloodPressure $type';
  static const String sexualActivity = 'Sexual Activity';
  static const String protectionUsed = 'Protection Used';
  static const String menstrualFlow = 'Menstrual Flow';
  static const String menstrualFlowInstant = 'Menstrual Flow (Instant)';
  static const String intermenstrualBleeding = 'Intermenstrual Bleeding';
  static const String flow = 'Flow';
  static const String isCycleStart = 'Is Cycle Start';
  static const String ovulationTest = 'Ovulation Test';
  static const String testResult = 'Test Result';
  static const String selectTestResult = 'Select test result';
  static const String appearance = 'Appearance';
  static const String sensation = 'Sensation';
  static const String optional = 'Optional';

  // Sexual Activity Protection
  static const String protected = 'Protected';
  static const String unprotected = 'Unprotected';

  // Ovulation Test Results
  static const String negative = 'Negative';
  static const String inconclusive = 'Inconclusive';
  static const String high = 'High';
  static const String positive = 'Positive';

  // Cervical Mucus
  static const String light = 'Light';
  static const String medium = 'Medium';
  static const String heavy = 'Heavy';
  static const String dry = 'Dry';
  static const String sticky = 'Sticky';
  static const String creamy = 'Creamy';
  static const String watery = 'Watery';
  static const String eggWhite = 'Egg White';
  static const String unusual = 'Unusual';
  static const String unspecified = 'Unspecified';
  static const String none = 'None';

  // endregion

  // region Device Types
  static const String deviceType = 'Device $type';
  static const String phone = 'Phone';
  static const String watch = 'Watch';
  static const String fitnessBand = 'Fitness Band';
  static const String ring = 'Ring';
  static const String scale = 'Scale';
  static const String chestStrap = 'Chest Strap';
  static const String headMounted = 'Head Mounted';
  static const String smartDisplay = 'Smart Display';

  // endregion

  // region Recording Methods
  static const String manualEntry = 'Manual Entry';
  static const String automaticallyRecorded = 'Automatically Recorded';
  static const String activelyRecorded = 'Actively Recorded';

  // endregion

  // region Measurement Units
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

  // endregion

  // region Units
  static const String kilogram = 'kg';
  static const String meter = 'm';
  static const String kilocalories = 'kcal';
  static const String percent = '%';
  static const String celsius = '°C';
  static const String liter = 'L';
  static const String millimetersOfMercury = 'mmHg';
  static const String breathsPerMinute = 'breaths/min';
  static const String millilitersPerKilogramPerMinute = 'mL/kg/min';
  static const String bpm = 'BPM';
  static const String perMinute = '/min';
  static const String perSecond = '/s';
  static const String frequency = 'Frequency';
  static const String milligramsPerDeciliter = 'mg/dL';
  static const String gram = 'g';
  static const String milligram = 'mg';
  static const String microgram = 'mcg';
  static const String seconds = 'sec';
  static const String pound = 'lbs';
  static const String ounce = 'oz';
  static const String kilometer = 'km';
  static const String centimeter = 'cm';
  static const String millimeter = 'mm';
  static const String millisecond = 'ms';
  static const String mile = 'mi';
  static const String foot = 'ft';
  static const String inch = 'in';
  static const String calories = 'cal';
  static const String kilojoule = 'kJ';
  static const String joule = 'J';
  static const String milliliter = 'mL';
  static const String fluidOunceUS = 'fl oz (US)';
  static const String fluidOunceImp = 'fl oz (Imp)';
  static const String fahrenheit = '°F';
  static const String kelvin = 'K';
  static const String pascal = 'Pa';
  static const String millimolesPerLiter = 'mmol/L';
  static const String watt = 'W';
  static const String kilowatt = 'kW';
  static const String metersPerSecond = 'm/s';
  static const String kilometersPerHour = 'km/h';
  static const String milesPerHour = 'mph';
  static const String hours = 'hours';
  static const String minutes = 'minutes';
  static const String secondsFull = 'seconds';
  static const String hourShort = 'h';
  static const String minuteShort = 'm';
  static const String decimal = '(decimal)';

  // endregion

  // region Aggregation Metrics
  static const String aggregationMetric = 'Aggregation Metric';
  static const String aggregate = 'Aggregate';
  static const String sum = 'Sum';
  static const String average = 'Average';
  static const String minimum = 'Minimum';
  static const String maximum = 'Maximum';
  static const String timeRange = '$time Range';
  static const String aggregationResult = 'Aggregation Result';

  // endregion

  // region Permissions
  static const String permissions = 'Permissions';
  static const String read = 'Read';
  static const String write = 'Write';
  static const String requestPermissions = 'Request $permissions';
  static const String dataTypePermissions = 'Data $type $permissions';
  static const String featurePermissions = 'Feature $permissions';
  static const String feature = 'Feature';
  static const String interval = 'Interval';
  static const String readHealthDataInBackground =
      'Read Health Data in Background';
  static const String readHealthDataHistory = '$read Health Data History';

  // endregion

  // region Common Success Messages
  static const String successfullyWroteRecord =
      'Successfully wrote record with ID';
  static const String recordDeletedSuccessfully = 'Record deleted successfully';
  static const String requestCompleted = 'Request completed';

  // endregion

  // region Common Error Messages
  static const String errorOccurred = 'An Error Occurred';
  static const String errorPrefixColon = 'Error';
  static const String failedToRequestPermissions =
      'Failed to request permissions';
  static const String failedToLoadFeatureStatuses =
      'Failed to load feature statuses';
  static const String failedToLaunchHealthAppStore =
      'Failed to launch health app store';

  // endregion

  // region Permission Error Messages
  static const String readPermissionDenied =
      'Read permission denied or not supported. Please grant read permission.';

  // endregion

  // region Validation Messages
  static const String invalidNumber = 'Invalid number';
  static const String cannotBeNegative = 'Cannot be negative';
  static const String maximumDecimalPlacesAllowed =
      'Maximum 3 decimal places allowed';
  static const String exceedsReasonableLimitEnergy =
      'Exceeds reasonable limit (5000 kcal)';
  static const String exceedsReasonableLimitMass =
      'Exceeds reasonable limit (10000 g)';
  static const String pleaseSelectBothStartAndEndDateTime =
      'Please select both start and end date/time';
  static const String pleaseSelectBloodPressureType =
      'Please select a blood pressure type';
  static const String pleaseSelectDateTime = 'Please select a date and time';
  static const String pleaseSelectDataType = 'Please select a data type';
  static const String pleaseSelectMetric = 'Please select a metric';
  static const String pleaseSelectDeviceType = 'Please select a device type';
  static const String pleaseSelectRecordingMethod =
      'Please select a recoding method';
  static const String pleaseSelectAtLeastOnePermission =
      'Please select at least one permission';
  static const String pleaseEnterValidNumber = '$pleaseEnter a valid number';
  static const String endTimeMustBeAfterStartTime =
      'End time must be after start time';
  static const String countMustBeNonNegative = 'Count must be non-negative';
  static const String bodyFatPercentageMustBeBetween0And100 =
      'Body fat percentage must be between 0 and 100';
  static const String pageSizeMustBeBetween1And10000 =
      'Page size must be between 1 and 10000';
  static const String systolicBloodPressureMustBeGreaterThanZero =
      'Systolic blood pressure must be greater than 0';
  static const String diastolicBloodPressureMustBeGreaterThanZero =
      'Diastolic blood pressure must be greater than 0';
  static const String durationMustBeGreaterThanZero =
      'Duration must be greater than 0';
  static const String failedToCalculateEndTime = 'Failed to calculate end time';
  static const String pleaseSelectSleepStageType =
      'Please select a sleep stage type';
  static const String titleOptional = 'Title (optional)';
  static const String optionalTitleSleepRecord =
      'Optional title for the sleep record';
  static const String notesOptional = 'Notes (optional)';
  static const String optionalNotesSleepRecord =
      'Optional notes about the sleep record';
  static const String vo2MaxTestTypeLabel = 'VO2 Max Test Type';

  // endregion

  // region Page Titles and Actions
  static const String insertHealthRecord = '$insert Health Record';
  static const String readHealthRecords = '$read Health Records';
  static const String readAggregateData = '$read Aggregate Data';

  // endregion

  // region Page Actions
  static const String readRecords = '$read Records';
  static const String loadMore = 'Load More';

  // endregion

  // region Record Display
  static const String recordDetails = 'Record Details';
  static const String startLabel = 'Start';
  static const String endLabel = 'End';
  static const String records = 'record(s)';
  static const String foundRecords = 'Found';
  static const String moreAvailable = 'More available';
  static const String noRecordsFound = 'No records found';
  static const String pageSize = 'Page Size (1-10000)';
  static const String emptyHealthRecordListPlaceholder =
      'Try adjusting the date range or '
      'check if you have permission to read this data type.';

  // endregion

  // region Health Record Detail Fields
  static const String startZoneOffsetSeconds = 'Start Zone Offset ($seconds)';
  static const String endZoneOffsetSeconds = 'End Zone Offset ($seconds)';
  static const String zoneOffsetSeconds = 'Zone Offset ($seconds)';

  // endregion

  // region Health Record Metadata
  static const String metadata = 'Metadata';
  static const String dataOrigin = 'Data Origin';
  static const String dataOrigins = 'Data Origins';
  static const String dataOriginsHint = 'com.example1,com.example2';
  static const String dataOriginsHelper =
      'Comma-separated package names (optional)';
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

  // endregion

  // region Sleep Stage Types
  static const String sleepStageAwake = 'Awake';
  static const String sleepStageSleeping = 'Sleeping';
  static const String sleepStageOutOfBed = 'Out of Bed';
  static const String sleepStageLight = 'Light';
  static const String sleepStageDeep = 'Deep';
  static const String sleepStageRem = 'REM';
  static const String sleepStageInBed = 'In Bed';

  // endregion

  // region Meal Types
  static const String mealType = '$meal $type';
  static const String mealTypeBreakfast = 'Breakfast';
  static const String mealTypeLunch = 'Lunch';
  static const String mealTypeDinner = 'Dinner';
  static const String mealTypeSnack = 'Snack';
  static const String foodName = '$food Name';
  static const String food = 'Food';
  static const String meal = 'Meal';
  static const String relationToMeal = 'Relation to $meal';
  static const String relationToMealGeneral = 'General';
  static const String relationToMealFasting = 'Fasting';
  static const String relationToMealBeforeMeal = 'Before $meal';
  static const String relationToMealAfterMeal = 'After $meal';
  static const String specimenSource = 'Specimen Source';
  static const String specimenSourceInterstitialFluid = 'Interstitial Fluid';
  static const String specimenSourceCapillaryBlood = 'Capillary Blood';
  static const String specimenSourcePlasma = 'Plasma';
  static const String specimenSourceSerum = 'Serum';
  static const String specimenSourceTears = 'Tears';
  static const String specimenSourceWholeBlood = 'Whole Blood';

  // endregion

  // region data types
  static const String nutrition = 'Nutrition';
  static const String nutrients = 'nutrients';
  static const String energy = 'Energy';
  static const String caffeine = 'Caffeine';
  static const String protein = 'Protein';
  static const String totalCarbohydrate = 'Total Carbohydrate';
  static const String totalFat = 'Total Fat';
  static const String saturatedFat = 'Saturated Fat';
  static const String monounsaturatedFat = 'Monounsaturated Fat';
  static const String polyunsaturatedFat = 'Polyunsaturated Fat';
  static const String cholesterol = 'Cholesterol';
  static const String dietaryFiber = 'Dietary Fiber';
  static const String sugar = 'Sugar';

  // Mineral nutrients
  static const String calcium = 'Calcium';
  static const String iron = 'Iron';
  static const String magnesium = 'Magnesium';
  static const String manganese = 'Manganese';
  static const String phosphorus = 'Phosphorus';
  static const String potassium = 'Potassium';
  static const String selenium = 'Selenium';
  static const String sodium = 'Sodium';
  static const String zinc = 'Zinc';

  // Vitamin nutrients
  // Vitamin nutrients
  static const String vitaminA = 'Vitamin A';
  static const String vitaminB6 = 'Vitamin B6';
  static const String vitaminB12 = 'Vitamin B12';
  static const String vitaminC = 'Vitamin C';
  static const String vitaminD = 'Vitamin D';
  static const String vitaminE = 'Vitamin E';
  static const String vitaminK = 'Vitamin K';
  static const String thiamin = 'Thiamin';
  static const String thiaminB1 = 'Thiamin (B1)';
  static const String riboflavin = 'Riboflavin';
  static const String riboflavinB2 = 'Riboflavin (B2)';
  static const String niacin = 'Niacin';
  static const String niacinB3 = 'Niacin (B3)';
  static const String folate = 'Folate';
  static const String folateB9 = 'Folate (B9)';
  static const String biotin = 'Biotin';
  static const String biotinB7 = 'Biotin (B7)';
  static const String pantothenicAcid = 'Pantothenic Acid';
  static const String pantothenicAcidB5 = 'Pantothenic Acid (B5)';

  // endregion

  // region Nutrition Form Field Labels
  static const String foodNameOptional = '$food Name (optional)';
  static const String foodNameOptionalHelper = 'Optional name of the food item';
  static const String energyAndMacronutrients = '$energy \u0026 Macronutrients';
  static const String energyKcal = '$energy (kcal)';
  static const String energyMacronutrientsSubtitle =
      'Energy, protein, carbs, fats';
  static const String vitamins = 'Vitamins';
  static const String vitaminsSubtitle = '13 vitamin fields';
  static const String minerals = 'Minerals';
  static const String mineralsSubtitle = '9 mineral fields';
  static const String other = 'Other';
  static const String additionalNutrients = 'Additional nutrients';

  // endregion

  // region Incremental Data Sync
  static const String incrementalDataSync = 'Incremental Data Sync';
  static const String synchronizationCompleted = 'Synchronization completed';
  static const String token = 'Token UUID';
  static const String tokenExpired = 'Token Expired';
  static const String tokenExpiredContent =
      'The sync token has expired (typically after 30 days on Android). '
      'Would you like to clear the token and perform a full sync?';
  static const String clearAndSync = 'Clear & Sync';
  static const String clearSyncTokenQuestion = 'Clear Sync Token?';
  static const String clearSyncTokenContent =
      'This will reset the sync state. You will need to perform a full '
      'sync on the next synchronization.';
  static const String clear = 'Clear';
  static const String tokenClearedSuccessfully = 'Token cleared successfully';
  static const String synchronize = 'SYNCHRONIZE';
  static const String selectDataTypes = 'Select Data Types';
  static const String consoleLog = 'Console Log';
  static const String noLogsYet = 'No logs yet';
  static const String controlPanel = 'Control Panel';
  static const String syncResults = 'Sync Results';
  static const String upserted = 'upserted';
  static const String deleted = 'deleted';
  static const String upsertedRecords = 'Upserted Records';
  static const String deletedRecordIds = 'Deleted Record IDs';
  static const String clearToken = 'Clear Token';
  static const String syncToken = 'Sync Token';
  static const String noneInitialSync = 'No stored sync token found';
  static const String createdAt = 'Created At';
  static const String dataTypes = 'Data Types';
  static const String types = 'type(s)';
  static const String lastSync = 'Last Sync';

  // endregion

  // region Speed Data Types
  static const String speed = 'Speed';
  static const String walkingSpeed = 'Walking $speed';
  static const String runningSpeed = 'Running $speed';
  static const String stairAscentSpeed = 'Stair Ascent $speed';
  static const String stairDescentSpeed = 'Stair Descent $speed';
  static const String speedSamples = '$speed Samples';

  // endregion

  // region Power Data Types
  static const String powerSeries = '$power Series';
  static const String cyclingPower = 'Cycling $power';
  static const String powerSamples = '$power Samples';

  // endregion

  // region Cycling Cadence Data Types
  static const String cyclingPedalingCadence = 'Cycling Pedaling Cadence';
  static const String cyclingPedalingCadenceSamples =
      '$cyclingPedalingCadence Samples';
  static const String sampleRpm = 'Sample RPM';
  static const String rpm = 'RPM';

  // endregion

  // region Health Record Descriptions

  // Basic Health Metrics
  static const String stepsDescription =
      'Number of steps taken during physical activity';
  static const String weightDescription = 'Body weight measurement';
  static const String heightDescription = 'Body height measurement';
  static const String bodyFatPercentageDescription =
      'Percentage of body weight that is fat';
  static const String leanBodyMassDescription = 'Weight of body excluding fat';
  static const String bodyMassIndexDescription = 'Body mass index measurement';
  static const String waistCircumferenceDescription =
      'Waist circumference measurement';
  static const String bodyTemperatureDescription =
      'Core body temperature measurement';
  static const String basalBodyTemperatureDescription =
      'Basal body temperature measurement';
  static const String boneMassDescription = 'Bone mass measurement';
  static const String bodyWaterMassDescription = 'Body water mass measurement';
  static const String heartRateVariabilityRMSSDDescription =
      'Heart rate variability (RMSSD) measurement';
  static const String heartRateVariabilitySDNNDescription =
      'Heart rate variability (SDNN) measurement';

  // Blood Pressure
  static const String bloodPressureDescription =
      'Systolic and diastolic blood pressure measurements';
  static const String systolicBloodPressureDescription =
      'Pressure in arteries when heart beats';
  static const String diastolicBloodPressureDescription =
      'Pressure in arteries between heartbeats';

  // Distance Activities
  static const String distanceDescription =
      'Distance covered during physical activity';
  static const String cyclingDistanceDescription =
      'Distance covered while cycling';
  static const String downhillSnowSportsDistanceDescription =
      'Distance covered during downhill skiing or snowboarding';
  static const String paddleSportsDistanceDescription =
      'Distance covered during kayaking, canoeing, or paddling';
  static const String rowingDistanceDescription =
      'Distance covered while rowing';
  static const String sixMinuteWalkTestDistanceDescription =
      'Distance walked in 6 minutes (clinical assessment)';
  static const String skatingSportsDistanceDescription =
      'Distance covered while skating';
  static const String swimmingDistanceDescription =
      'Distance covered while swimming';
  static const String wheelchairDistanceDescription =
      'Distance covered using a wheelchair';
  static const String walkingRunningDistanceDescription =
      'Distance covered while walking or running';

  // Activity Metrics
  static const String activeEnergyBurnedDescription =
      'Energy burned through active movement';
  static const String basalEnergyBurnedDescription =
      'Energy burned by the body at rest to maintain basic functions';
  static const String totalEnergyBurnedDescription =
      'Sum of active and basal energy burned';
  static const String floorsClimbedDescription = 'Number of floors climbed';
  static const String wheelchairPushesDescription =
      'Number of wheelchair pushes';

  // Hydration
  static const String hydrationDescription = 'Volume of fluids consumed';

  // Heart Rate
  static const String heartRateRecordDescription =
      'Heart rate measurement at a specific point in time';
  static const String heartRateSeriesRecordDescription =
      'Heart rate measurements over a period of time';
  static const String restingHeartRateDescription = 'Heart rate while at rest';

  // Cycling Pedaling Cadence
  static const String cyclingPedalingCadenceRecordDescription =
      'Cycling pedaling cadence (RPM) at a specific point in time';
  static const String cyclingPedalingCadenceSeriesRecordDescription =
      'Cycling pedaling cadence (RPM) measurements over a period of time';

  // Sleep
  static const String sleepSessionDescription =
      'Period of sleep with optional stage information';
  static const String sleepStageRecordDescription =
      'Type of sleep stage during a sleep session';

  // Sexual Activity
  static const String sexualActivityDescription =
      'Record of sexual activity occurrence with optional '
      'protection information';

  // Cervical Mucus
  static const String cervicalMucusDescription =
      'Cervical mucus appearance and sensation observation';

  // Ovulation Test
  static const String ovulationTestDescription =
      'Ovulation test results to track fertility cycles';

  // Respiratory and Oxygen
  static const String oxygenSaturationDescription =
      'Percentage of oxygen in the blood';
  static const String respiratoryRateDescription =
      'Number of breaths per minute';
  static const String vo2MaxDescription =
      'Maximum oxygen consumption during intense exercise';

  // Blood Glucose
  static const String bloodGlucoseDescription = 'Blood glucose (sugar) level';

  // Nutrition
  static const String nutritionDescription =
      'Nutritional information from food and beverages';
  static const String energyDescription =
      'Energy content from food and beverages';
  static const String caffeineDescription = 'Amount of caffeine consumed';
  static const String proteinDescription = 'Protein intake from food';
  static const String totalCarbohydrateDescription =
      'Total carbohydrate intake';
  static const String totalFatDescription = 'Total fat intake';
  static const String saturatedFatDescription = 'Saturated fat intake';
  static const String monounsaturatedFatDescription =
      'Monounsaturated fat intake';
  static const String polyunsaturatedFatDescription =
      'Polyunsaturated fat intake';
  static const String cholesterolDescription = 'Dietary cholesterol intake';
  static const String dietaryFiberDescription = 'Dietary fiber intake';
  static const String sugarDescription = 'Sugar intake';

  // Minerals
  static const String calciumDescription = 'Calcium intake for bone health';
  static const String ironDescription = 'Iron intake for blood health';
  static const String magnesiumDescription =
      'Magnesium intake for muscle and nerve function';
  static const String manganeseDescription = 'Manganese intake for metabolism';
  static const String phosphorusDescription =
      'Phosphorus intake for bone and teeth health';
  static const String potassiumDescription =
      'Potassium intake for heart and muscle function';
  static const String seleniumDescription =
      'Selenium intake for antioxidant protection';
  static const String sodiumDescription = 'Sodium intake for fluid balance';
  static const String zincDescription = 'Zinc intake for immune function';

  // Vitamins
  static const String vitaminADescription =
      'Vitamin A intake for vision and immune health';
  static const String vitaminB6Description =
      'Vitamin B6 intake for brain development';
  static const String vitaminB12Description =
      'Vitamin B12 intake for nerve function';
  static const String vitaminCDescription =
      'Vitamin C intake for immune system support';
  static const String vitaminDDescription = 'Vitamin D intake for bone health';
  static const String vitaminEDescription =
      'Vitamin E intake for antioxidant protection';
  static const String vitaminKDescription =
      'Vitamin K intake for blood clotting';
  static const String thiaminDescription =
      'Thiamin (Vitamin B1) intake for energy metabolism';
  static const String riboflavinDescription =
      'Riboflavin (Vitamin B2) intake for energy production';
  static const String niacinDescription =
      'Niacin (Vitamin B3) intake for digestive system health';
  static const String folateDescription =
      'Folate (Vitamin B9) intake for cell growth';
  static const String biotinDescription =
      'Biotin (Vitamin B7) intake for hair and nail health';
  static const String pantothenicAcidDescription =
      'Pantothenic Acid (Vitamin B5) intake for energy metabolism';

  // Speed
  static const String speedDescription =
      'Speed of movement during physical activity';

  // endregion

  // region Exercise Session
  static const String exerciseSession = 'Exercise Session';
  static const String mindfulnessSession = 'Mindfulness Session';
  static const String exerciseType = 'Exercise Type';
  static const String exerciseTitleOptional = 'Title (optional)';
  static const String exerciseTitleHelper = 'Optional title for the exercise';
  static const String exerciseNotesOptional = 'Notes (optional)';
  static const String exerciseNotesHelper = 'Optional notes about the exercise';

  // Exercise Types - Common (Android + iOS)
  static const String exerciseRunning = 'Running';
  static const String exerciseWalking = 'Walking';
  static const String exerciseCycling = 'Cycling';
  static const String exerciseHiking = 'Hiking';
  static const String exerciseSwimming = 'Swimming';
  static const String exerciseSurfing = 'Surfing';
  static const String exerciseWaterPolo = 'Water Polo';
  static const String exerciseRowing = 'Rowing';
  static const String exerciseSailing = 'Sailing';
  static const String exercisePaddling = 'Paddling';
  static const String exerciseStrengthTraining = 'Strength Training';
  static const String exerciseTraditionalStrengthTraining =
      'Traditional Strength Training';
  static const String exerciseFunctionalStrengthTraining =
      'Functional Strength Training';
  static const String exerciseCalisthenics = 'Calisthenics';
  static const String exerciseBasketball = 'Basketball';
  static const String exerciseSoccer = 'Soccer';
  static const String exerciseAmericanFootball = 'American Football';
  static const String exerciseAustralianFootball = 'Australian Football';
  static const String exerciseBaseball = 'Baseball';
  static const String exerciseSoftball = 'Softball';
  static const String exerciseVolleyball = 'Volleyball';
  static const String exerciseRugby = 'Rugby';
  static const String exerciseCricket = 'Cricket';
  static const String exerciseHandball = 'Handball';
  static const String exerciseIceHockey = 'Ice Hockey';
  static const String exerciseTennis = 'Tennis';
  static const String exerciseTableTennis = 'Table Tennis';
  static const String exerciseBadminton = 'Badminton';
  static const String exerciseSquash = 'Squash';
  static const String exerciseRacquetball = 'Racquetball';
  static const String exerciseSkiing = 'Skiing';
  static const String exerciseSnowboarding = 'Snowboarding';
  static const String exerciseIceSkating = 'Ice Skating';
  static const String exerciseSkating = 'Skating';
  static const String exerciseBoxing = 'Boxing';
  static const String exerciseMartialArts = 'Martial Arts';
  static const String exerciseWrestling = 'Wrestling';
  static const String exerciseFencing = 'Fencing';
  static const String exerciseDancing = 'Dancing';
  static const String exerciseGymnastics = 'Gymnastics';
  static const String exerciseYoga = 'Yoga';
  static const String exercisePilates = 'Pilates';
  static const String exerciseHIIT = 'High-Intensity Interval Training';
  static const String exerciseElliptical = 'Elliptical';
  static const String exerciseStairClimbing = 'Stair Climbing';
  static const String exerciseGolf = 'Golf';
  static const String exerciseRockClimbing = 'Rock Climbing';
  static const String exerciseWheelchair = 'Wheelchair';

  // Exercise Types - iOS only
  static const String exercisePickleball = 'Pickleball';
  static const String exerciseDiscSports = 'Disc Sports';
  static const String exerciseFitnessGaming = 'Fitness Gaming';
  static const String exerciseBarre = 'Barre';
  static const String exerciseTaiChi = 'Tai Chi';
  static const String exerciseMixedCardio = 'Mixed Cardio';
  static const String exerciseHandCycling = 'Hand Cycling';
  static const String exerciseCooldown = 'Cooldown';
  static const String exerciseFlexibility = 'Flexibility';
  static const String exerciseArchery = 'Archery';
  static const String exerciseBowling = 'Bowling';
  static const String exerciseCurling = 'Curling';
  static const String exerciseEquestrianSports = 'Equestrian Sports';
  static const String exerciseFishing = 'Fishing';
  static const String exerciseHunting = 'Hunting';
  static const String exerciseLacrosse = 'Lacrosse';
  static const String exerciseMindAndBody = 'Mind and Body';
  static const String exercisePlay = 'Play';
  static const String exercisePreparationAndRecovery =
      'Preparation and Recovery';
  static const String exerciseStairs = 'Stairs';
  static const String exerciseStepTraining = 'Step Training';
  static const String exerciseTrackAndField = 'Track and Field';
  static const String exerciseTransition = 'Transition';
  static const String exerciseUnderwaterDiving = 'Underwater Diving';
  static const String exerciseCrossCountrySkiing = 'Cross-Country Skiing';
  static const String exerciseDownhillSkiing = 'Downhill Skiing';
  static const String exerciseSnowSports = 'Snow Sports';
  static const String exercisePaddleSports = 'Paddle Sports';
  static const String exerciseCardioDance = 'Cardio Dance';
  static const String exerciseSocialDance = 'Social Dance';
  static const String exerciseCoreTraining = 'Core Training';

  // Health Connect specific or new cross-platform types
  static const String exerciseOtherWorkout = 'Other Workout';
  static const String exerciseBikingStationary = 'Stationary Biking';
  static const String exerciseBootCamp = 'Boot Camp';
  static const String exerciseExerciseClass = 'Exercise Class';
  static const String exerciseFrisbeeDisc = 'Frisbee Disc';
  static const String exerciseGuidedBreathing = 'Guided Breathing';
  static const String exerciseParagliding = 'Paragliding';
  static const String exerciseRollerHockey = 'Roller Hockey';
  static const String exerciseRowingMachine = 'Rowing Machine';
  static const String exerciseRunningTreadmill = 'Treadmill Running';
  static const String exerciseScubaDiving = 'Scuba Diving';
  static const String exerciseSnowshoeing = 'Snowshoeing';
  static const String exerciseStairClimbingMachine = 'Stair Climbing Machine';
  static const String exerciseStretching = 'Stretching';
  static const String exerciseSwimmingOpenWater = 'Open Water Swimming';
  static const String exerciseSwimmingPool = 'Pool Swimming';
  static const String exerciseWeightlifting = 'Weightlifting';
  static const String exerciseWaterFitness = 'Water Fitness';
  static const String exerciseWaterSports = 'Water Sports';
  static const String exerciseHockey = 'Hockey';
  static const String exerciseKickboxing = 'Kickboxing';
  static const String exerciseJumpRope = 'Jump Rope';
  static const String exerciseCrossTraining = 'Cross Training';
  static const String exerciseClimbing = 'Climbing';
  static const String exerciseSwimBikeRun = 'Multisport';
  static const String exerciseWheelchairWalkPace = 'Wheelchair Walk Pace';
  static const String exerciseWheelchairRunPace = 'Wheelchair Run Pace';

  // endregion
}
