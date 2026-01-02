abstract class FakeData {
  static const fakeId = 'test-id-123';
  static const fakeDataOrigin = 'com.example.healthapp';

  // Fake start time data for `IntervalHealthRecord` and `SeriesHealthRecord`
  static final fakeLocalStartTime = DateTime.parse(
    '2026-01-01T10:00:00+01:00',
  );
  static final fakeStartTime = fakeLocalStartTime.toUtc();
  static final fakeEndTimeZoneOffsetSeconds =
      fakeLocalEndTime.timeZoneOffset.inSeconds;

  // Fake end time data for `IntervalHealthRecord` and `SeriesHealthRecord`
  static final fakeLocalEndTime = DateTime.parse(
    '2026-01-01T11:30:00+01:00',
  );
  static final fakeEndTime = fakeLocalEndTime.toUtc();
  static final fakeStartTimeZoneOffsetSeconds =
      fakeLocalStartTime.timeZoneOffset.inSeconds;

  // Fake time data for `InstantHealthRecord`
  static final fakeLocalTime = fakeLocalStartTime;
  static final fakeTime = fakeStartTime;
  static final fakeZoneOffsetSeconds = fakeEndTimeZoneOffsetSeconds;
}
