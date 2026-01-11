part of '../health_record.dart';

/// Represents different types of physical exercises.
///
/// This enum provides a comprehensive catalog of exercise types supported
/// across Android Health Connect and iOS HealthKit platforms.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to
///   `ExerciseSessionRecord.EXERCISE_TYPE_*` constants
/// - **iOS HealthKit**: Maps to `HKWorkoutActivityType` enum values
///
/// ## Cross-Platform Types
///
/// Most common exercise types (~50) are supported on both platforms, including:
/// - Cardio: running, walking, cycling, swimming
/// - Strength: strength training, calisthenics, weightlifting
/// - Sports: basketball, soccer, tennis, golf
/// - Fitness: yoga, pilates, HIIT
///
/// ## Platform-Specific Types
///
/// Some types are only available on specific platforms:
/// - **iOS-only**: Types annotated with `@supportedOnAppleHealth` (e.g.,
///   [waterFitness], [pickleball]).
/// - **Android-only**: Types annotated with `@supportedOnHealthConnect` (e.g.,
///   [runningTreadmill], [weightlifting]).
///
/// Attempting to use a platform-specific type on an unsupported platform will
/// result in a runtime error.
///
/// > **Important:** Attempting to use a platform-specific type on an
/// > unsupported platform will result in [UnsupportedOperationException].
///
/// {@category Health Records}
@sinceV2_0_0
enum ExerciseType {
  /// Other or unclassified workout.
  ///
  /// Use this for workouts that don't fit into any specific category.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.other`
  /// - **Android Health Connect**: `EXERCISE_TYPE_OTHER_WORKOUT`
  other,

  //region Cardio & Walking/Running

  /// Running activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.running`
  /// - **Android Health Connect**: `EXERCISE_TYPE_RUNNING`
  running,

  /// Running on a treadmill.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_RUNNING_TREADMILL`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  runningTreadmill,

  /// Walking activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.walking`
  /// - **Android Health Connect**: `EXERCISE_TYPE_WALKING`
  walking,

  /// Cycling or biking activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.cycling`
  /// - **Android Health Connect**: `EXERCISE_TYPE_BIKING`
  cycling,

  /// Stationary cycling or biking.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_BIKING_STATIONARY`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  cyclingStationary,

  /// Hiking activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.hiking`
  /// - **Android Health Connect**: `EXERCISE_TYPE_HIKING`
  hiking,

  /// Hand cycling (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.handCycling`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  handCycling,

  /// Track and field activities (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.trackAndField`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  trackAndField,

  //endregion

  //region Water Sports

  /// Swimming activity (pool or open water).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.swimming`
  /// - **Android Health Connect**: Not supported  (Use `swimmingPool` or
  /// `swimmingOpenWater`)
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  swimming,

  /// Swimming in open water.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_SWIMMING_OPEN_WATER`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  swimmingOpenWater,

  /// Swimming in a pool.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_SWIMMING_POOL`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  swimmingPool,

  /// Surfing activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.surfingSports`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SURFING`
  surfing,

  /// Water polo sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.waterPolo`
  /// - **Android Health Connect**: `EXERCISE_TYPE_WATER_POLO`
  waterPolo,

  /// Rowing activity.
  ///
  /// Includes both water rowing and rowing machine exercises.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.rowing`
  /// - **Android Health Connect**: `ExerciseSessionRecord.EXERCISE_TYPE_ROWING`
  ///
  /// **Note:** This unified type covers both water rowing and indoor rowing
  /// machines, as the biomechanics are identical.
  rowing,

  /// Sailing activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.sailing`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SAILING`
  sailing,

  /// Paddling sports (kayaking, canoeing, stand-up paddleboarding).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.paddleSports`
  /// - **Android Health Connect**: `EXERCISE_TYPE_PADDLING`
  paddling,

  /// Diving activities including scuba diving and free diving.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.underwaterDiving`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SCUBA_DIVING`
  diving,

  /// Water fitness.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.waterFitness`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  waterFitness,

  /// Water sports.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.waterSports`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  waterSports,

  //endregion

  //region Strength Training

  /// General strength training activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.traditionalStrengthTraining`
  /// - **Android Health Connect**: `EXERCISE_TYPE_STRENGTH_TRAINING`
  strengthTraining,

  /// Weightlifting with barbells and dumbbells.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_WEIGHTLIFTING`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  weightlifting,

  /// Calisthenics (bodyweight exercises).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_CALISTHENICS`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  calisthenics,

  //endregion

  //region Team Sports

  /// Basketball sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.basketball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_BASKETBALL`
  basketball,

  /// Soccer (football) sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.soccer`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SOCCER`
  soccer,

  /// American football sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.americanFootball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_FOOTBALL_AMERICAN`
  americanFootball,

  /// Frisbee disc sports.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.discSports`
  /// - **Android Health Connect**: `EXERCISE_TYPE_FRISBEE_DISC`
  frisbeeDisc,

  /// Australian rules football sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.australianFootball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_FOOTBALL_AUSTRALIAN`
  australianFootball,

  /// Baseball sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.baseball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_BASEBALL`
  baseball,

  /// Softball sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.softball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SOFTBALL`
  softball,

  /// Volleyball sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.volleyball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_VOLLEYBALL`
  volleyball,

  /// Rugby sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.rugby`
  /// - **Android Health Connect**: `EXERCISE_TYPE_RUGBY`
  rugby,

  /// Cricket sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.cricket`
  /// - **Android Health Connect**: `EXERCISE_TYPE_CRICKET`
  cricket,

  /// Handball sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.handball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_HANDBALL`
  handball,

  /// Ice hockey sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_ICE_HOCKEY`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  iceHockey,

  /// Roller hockey sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_ROLLER_HOCKEY`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  rollerHockey,

  /// Field hockey sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.hockey`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  hockey,

  /// Lacrosse sport (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.lacrosse`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  lacrosse,

  /// Disc sports like frisbee or disc golf (iOS HealthKit only).
  ///
  /// Note: `frisbeeDisc` handles common cases, but this exists for specific
  /// HK support.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.discSports`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  discSports,

  //endregion

  //region Racquet Sports

  /// Tennis sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.tennis`
  /// - **Android Health Connect**: `EXERCISE_TYPE_TENNIS`
  tennis,

  /// Table tennis (ping pong) sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.tableTennis`
  /// - **Android Health Connect**: `EXERCISE_TYPE_TABLE_TENNIS`
  tableTennis,

  /// Badminton sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.badminton`
  /// - **Android Health Connect**: `EXERCISE_TYPE_BADMINTON`
  badminton,

  /// Squash sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.squash`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SQUASH`
  squash,

  /// Racquetball sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.racquetball`
  /// - **Android Health Connect**: `EXERCISE_TYPE_RACQUETBALL`
  racquetball,

  /// Pickleball sport (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.pickleball`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  pickleball,

  //endregion

  //region Winter Sports

  /// Skiing activity (downhill, cross-country).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported. Use [crossCountrySkiing] or
  ///   [downhillSkiing] instead.
  /// - **Android Health Connect**: `EXERCISE_TYPE_SKIING`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  skiing,

  /// Snowboarding activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.snowboarding`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SNOWBOARDING`
  snowboarding,

  /// Snowshoeing activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_SNOWSHOEING`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  snowshoeing,

  /// Skating activity.
  ///
  /// Includes ice skating, inline skating, and roller skating.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.skatingSports`
  /// - **Android Health Connect**: `EXERCISE_TYPE_SKATING`
  ///
  /// **Note:** This unified type covers ice skating and inline/roller skating.
  /// `EXERCISE_TYPE_ICE_SKATING` on Android Health Connect is ignored.
  skating,

  /// Cross-country skiing (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.crossCountrySkiing`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  crossCountrySkiing,

  /// Curling sport (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.curling`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  curling,

  /// Downhill skiing (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.downhillSkiing`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  downhillSkiing,

  /// Snow sports general (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.snowSports`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  snowSports,

  //endregion

  //region Martial Arts & Combat Sports

  /// Boxing sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.boxing`
  /// - **Android Health Connect**: `EXERCISE_TYPE_BOXING`
  boxing,

  /// Kickboxing sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.kickboxing`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  kickboxing,

  /// General martial arts training.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.martialArts`
  /// - **Android Health Connect**: `EXERCISE_TYPE_MARTIAL_ARTS`
  martialArts,

  /// Wrestling sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.wrestling`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  wrestling,

  /// Fencing sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.fencing`
  /// - **Android Health Connect**: `EXERCISE_TYPE_FENCING`
  fencing,

  /// Tai chi practice (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.taiChi`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  taiChi,

  //endregion

  //region Dance & Gymnastics

  /// Dancing activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.dance` (deprecated) or`cardioDance`/`socialDance`
  /// - **Android Health Connect**: `EXERCISE_TYPE_DANCING`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  dancing,

  /// Gymnastics activity.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.gymnastics`
  /// - **Android Health Connect**: `EXERCISE_TYPE_GYMNASTICS`
  gymnastics,

  /// Barre exercise (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.barre`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  barre,

  /// Cardio dance (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.cardioDance`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  cardioDance,

  /// Social dance (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.socialDance`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  socialDance,

  //endregion

  //region Fitness & Conditioning

  /// Yoga practice.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.yoga`
  /// - **Android Health Connect**: `EXERCISE_TYPE_YOGA`
  yoga,

  /// Pilates exercise.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.pilates`
  /// - **Android Health Connect**: `EXERCISE_TYPE_PILATES`
  pilates,

  /// High-intensity interval training (HIIT).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.highIntensityIntervalTraining`
  /// - **Android Health Connect**:
  ///   `EXERCISE_TYPE_HIGH_INTENSITY_INTERVAL_TRAINING`
  highIntensityIntervalTraining,

  /// Elliptical trainer machine exercise.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.elliptical`
  /// - **Android Health Connect**: `EXERCISE_TYPE_ELLIPTICAL`
  elliptical,

  /// Exercise class.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_EXERCISE_CLASS`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  exerciseClass,

  /// Boot camp training.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_BOOT_CAMP`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  bootCamp,

  /// Guided breathing session.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKCategoryTypeIdentifier.mindfulSession`
  /// - **Android Health Connect**: `EXERCISE_TYPE_GUIDED_BREATHING`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  guidedBreathing,

  /// Stair climbing activity.
  ///
  /// Includes climbing real stairs, stair stepper machines, and stair climbers.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.stairClimbing`
  /// - **Android Health Connect**:
  ///   `ExerciseSessionRecord.EXERCISE_TYPE_STAIR_CLIMBING`
  ///
  /// **Note:** This unified type covers both real stairs and stair climbing
  /// machines.
  stairClimbing,

  /// Cross training.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.crossTraining`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  crossTraining,

  /// Jump rope exercise.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.jumpRope`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  jumpRope,

  /// Fitness gaming activities (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.fitnessGaming`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  fitnessGaming,

  /// Mixed cardio exercise (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.mixedCardio`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  mixedCardio,

  /// Cooldown activity (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.cooldown`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  cooldown,

  /// Flexibility and stretching exercises.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.flexibility`
  /// - **Android Health Connect**: `EXERCISE_TYPE_STRETCHING`
  flexibility,

  /// Mind and body exercises (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.mindAndBody`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  mindAndBody,

  /// Preparation and recovery (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.preparationAndRecovery`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  preparationAndRecovery,

  /// Step training (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.stepTraining`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  stepTraining,

  /// Core training (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.coreTraining`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  coreTraining,

  //endregion

  //region Golf & Precision Sports

  /// Golf sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.golf`
  /// - **Android Health Connect**: `EXERCISE_TYPE_GOLF`
  golf,

  /// Archery sport (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.archery`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  archery,

  /// Bowling sport (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.bowling`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  bowling,

  //endregion

  //region Outdoor & Adventure

  /// Paragliding.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_PARAGLIDING`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  paragliding,

  /// Climbing activity (including rock climbing and bouldering).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.climbing`
  /// - **Android Health Connect**: `EXERCISE_TYPE_ROCK_CLIMBING`
  climbing,

  /// Equestrian sports (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.equestrianSports`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  equestrianSports,

  /// Fishing activity (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.fishing`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  fishing,

  /// Hunting activity (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.hunting`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  hunting,

  /// Play (general) activity (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.play`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  play,

  //endregion

  //region Wheelchair Activities

  /// Wheelchair-based exercise or sport.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: Not supported
  /// - **Android Health Connect**: `EXERCISE_TYPE_WHEELCHAIR`
  ///
  /// Throws [UnsupportedOperationException] on iOS HealthKit.
  @supportedOnHealthConnect
  wheelchair,

  /// Wheelchair walk pace.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.wheelchairWalkPace`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  wheelchairWalkPace,

  /// Wheelchair run pace.
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.wheelchairRunPace`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  wheelchairRunPace,

  //endregion

  //region Multisport

  /// Transition between activities (iOS HealthKit only).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.transition`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  transition,

  /// Multisport (Swim Bike Run / Triathlon).
  ///
  /// **Platform Mappings:**
  /// - **iOS HealthKit**: `HKWorkoutActivityType.swimBikeRun`
  /// - **Android Health Connect**: Not supported
  ///
  /// Throws [UnsupportedOperationException] on Android Health Connect.
  @supportedOnAppleHealth
  swimBikeRun,

  //endregion
}

/// Extension on [ExerciseType] that provides static getters for
/// platform-specific supported exercise types.
///
/// This extension helps filter exercise types based on platform availability,
/// making it easier to present only valid options to users on each platform.
///
/// ## Example
///
/// ```dart
/// // Get all exercise types supported on Apple Health (iOS)
/// final iosTypes = ExerciseType.appleHealthTypes;
///
/// // Get all exercise types supported on Health Connect (Android)
/// final androidTypes = ExerciseType.healthConnectTypes;
/// ```
///
/// {@category Health Records}
@sinceV2_0_0
extension ExerciseTypeExtension on ExerciseType {
  /// Returns a list of all [ExerciseType] values supported on Apple Health
  /// (iOS HealthKit).
  static List<ExerciseType> get appleHealthTypes => ExerciseType.values
      .where((type) => !_healthConnectOnlyTypes.contains(type))
      .toList();

  /// Returns a list of all [ExerciseType] values supported on Health Connect
  /// (Android).
  static List<ExerciseType> get healthConnectTypes => ExerciseType.values
      .where((type) => !_appleHealthOnlyTypes.contains(type))
      .toList();

  /// Checks if this exercise type is supported on the given [platform].
  bool isSupportedOnPlatform(HealthPlatform platform) {
    switch (platform) {
      case HealthPlatform.appleHealth:
        return !_healthConnectOnlyTypes.contains(this);
      case HealthPlatform.healthConnect:
        return !_appleHealthOnlyTypes.contains(this);
    }
  }

  /// Returns a list of [ExerciseType] values that are exclusively supported on
  /// the given [platform].
  ///
  /// ## Parameters
  ///
  /// - [platform]: The health platform to get exclusive exercise types for.
  ///
  /// ## Returns
  ///
  /// A list of [ExerciseType] values that are only supported on the given
  /// [platform]:
  /// - For [HealthPlatform.appleHealth]: Returns iOS-only types (annotated
  ///   with @[supportedOnAppleHealth])
  /// - For [HealthPlatform.healthConnect]: Returns Android-only types
  ///   (annotated with @[supportedOnHealthConnect])
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Get iOS-exclusive exercise types
  /// final iosOnlyTypes = ExerciseType.other.getExerciseTypesForPlatform(
  ///   HealthPlatform.appleHealth,
  /// );
  /// // Returns: [swimming, waterFitness, kickboxing, ...]
  ///
  /// // Get Android-exclusive exercise types
  /// final androidOnlyTypes = ExerciseType.other.getExerciseTypesForPlatform(
  ///   HealthPlatform.healthConnect,
  /// );
  /// // Returns: [runningTreadmill, cyclingStationary, weightlifting, ...]
  /// ```
  List<ExerciseType> getExerciseTypesForPlatform(HealthPlatform platform) {
    switch (platform) {
      case HealthPlatform.appleHealth:
        return _appleHealthOnlyTypes.toList();
      case HealthPlatform.healthConnect:
        return _healthConnectOnlyTypes.toList();
    }
  }

  /// Internal sets for platform validation based on Android Health Connect
  /// support. The lists must match the [supportedOnHealthConnect] annotation
  /// on the enum values.
  static const Set<ExerciseType> _healthConnectOnlyTypes = {
    ExerciseType.runningTreadmill,
    ExerciseType.cyclingStationary,
    ExerciseType.swimmingOpenWater,
    ExerciseType.swimmingPool,
    ExerciseType.weightlifting,
    ExerciseType.calisthenics,
    ExerciseType.iceHockey,
    ExerciseType.rollerHockey,
    ExerciseType.skiing,
    ExerciseType.snowshoeing,
    ExerciseType.dancing,
    ExerciseType.exerciseClass,
    ExerciseType.bootCamp,
    ExerciseType.guidedBreathing,
    ExerciseType.paragliding,
    ExerciseType.wheelchair,
  };

  /// Internal sets for platform validation based on iOS HealthKit support.
  /// The lists must match the [supportedOnAppleHealth] annotation on the enum
  /// values.
  static const Set<ExerciseType> _appleHealthOnlyTypes = {
    ExerciseType.swimming,
    ExerciseType.waterFitness,
    ExerciseType.waterSports,
    ExerciseType.hockey,
    ExerciseType.kickboxing,
    ExerciseType.wrestling,
    ExerciseType.crossTraining,
    ExerciseType.jumpRope,
    ExerciseType.wheelchairWalkPace,
    ExerciseType.wheelchairRunPace,
    ExerciseType.swimBikeRun,
    ExerciseType.pickleball,
    ExerciseType.discSports,
    ExerciseType.fitnessGaming,
    ExerciseType.barre,
    ExerciseType.taiChi,
    ExerciseType.mixedCardio,
    ExerciseType.handCycling,
    ExerciseType.cooldown,
    ExerciseType.archery,
    ExerciseType.bowling,
    ExerciseType.curling,
    ExerciseType.equestrianSports,
    ExerciseType.fishing,
    ExerciseType.hunting,
    ExerciseType.lacrosse,
    ExerciseType.mindAndBody,
    ExerciseType.play,
    ExerciseType.preparationAndRecovery,
    ExerciseType.stepTraining,
    ExerciseType.trackAndField,
    ExerciseType.transition,
    ExerciseType.crossCountrySkiing,
    ExerciseType.downhillSkiing,
    ExerciseType.snowSports,
    ExerciseType.cardioDance,
    ExerciseType.socialDance,
    ExerciseType.coreTraining,
  };
}
