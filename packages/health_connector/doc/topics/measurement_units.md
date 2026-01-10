# Measurement Units

Type-safe measurement classes with automatic unit conversion for health data.

## Overview

The Health Connector provides a comprehensive set of immutable, type-safe measurement unit classes
that handle automatic conversions between different units. Each measurement type is implemented as a
sealed class with named constructors for different units and getter methods for conversions.

## Key Features

- **Compile-time type safety**: Prevents mixing incompatible measurement types
- **Automatic unit conversion**: Convert between units seamlessly
- **Immutability**: All measurement instances are immutable
- **Arithmetic operations**: Support for addition, subtraction, and comparisons
- **Tolerance-based equality**: Medical-grade floating-point comparisons
- **Zero constants**: Pre-defined zero values for each type


## Quick Reference

| Type           | Units                     | Base Unit | Common Use Cases       |
|----------------|---------------------------|-----------|------------------------|
| `Mass`         | kg, g, lb, oz             | kg        | Body weight, nutrition |
| `Energy`       | kcal, cal, kJ, J          | kcal      | Calories, BMR          |
| `Length`       | m, km, cm, mm, mi, ft, in | m         | Distance, height       |
| `Volume`       | L, mL, fl oz (US/Imp)     | L         | Hydration, fluids      |
| `Temperature`  | °C, °F, K                 | °C        | Body temperature       |
| `Pressure`     | mmHg, Pa                  | mmHg      | Blood pressure         |
| `BloodGlucose` | mmol/L, mg/dL             | mmol/L    | Glucose monitoring     |
| `Number`       | value                     | N/A       | Steps, counts          |
| `Percentage`   | decimal, whole            | decimal   | Body fat, O₂ sat       |
| `Power`        | W, kW                     | W         | Exercise power         |
| `TimeDuration` | s, min, h                 | s         | Sleep, exercise        |
| `Velocity`     | m/s, km/h, mph            | m/s       | Running, cycling       |

## Unit Categories


### Mass

Used for body weight, body composition measurements, and nutrition data.

**Available Units**: kilograms, grams, pounds, ounces  
**Base Unit**: kilograms

```dart
final weight = Mass.pounds(155.4);
print(weight.inKilograms); // ~70.5
print(weight.inGrams);     // ~70500.0

final difference = Mass.kilograms(75.0) - Mass.kilograms(70.5);
print(difference.inPounds); // ~9.92
```

### Energy

Used for energy burned, basal metabolic rate, and nutritional content.

**Available Units**: kilocalories, calories, kilojoules, joules  
**Base Unit**: kilocalories

```dart
final energy = Energy.kilocalories(2000);
print(energy.inKilojoules); // ~8368.0
print(energy.inCalories);   // 2000000.0

final total = Energy.kilocalories(1500) + Energy.kilocalories(500);
print(total.inKilocalories); // 2000.0
```

### Length

Used for distance traveled, height, and other length measurements.

**Available Units**: meters, kilometers, centimeters, millimeters, miles, feet, inches  
**Base Unit**: meters

```dart
final distance = Length.kilometers(5);
print(distance.inMeters);     // 5000.0
print(distance.inMiles);      // ~3.11

final height = Length.feet(5) + Length.inches(10);
print(height.inCentimeters);  // ~177.8
```

### Volume

Used for hydration tracking, blood volume, and fluid intake.

**Available Units**: liters, milliliters, US fluid ounces, Imperial fluid ounces  
**Base Unit**: liters

```dart
final hydration = Volume.fluidOuncesUs(64);
print(hydration.inLiters);      // ~1.89
print(hydration.inMilliliters); // ~1893.0
```

### Temperature

Used for body temperature measurements.

**Available Units**: Celsius, Fahrenheit, Kelvin  
**Base Unit**: Celsius

```dart
final temp = Temperature.fahrenheit(98.6);
print(temp.inCelsius); // 37.0
print(temp.inKelvin);  // 310.15
```

### Pressure

Used for blood pressure measurements.

**Available Units**: millimeters of mercury (mmHg), pascals  
**Base Unit**: mmHg

```dart
final systolic = Pressure.millimetersOfMercury(120);
print(systolic.inPascals); // ~15998.7
```

### Blood Glucose

Used for diabetes management and glucose monitoring.

**Available Units**: millimoles per liter (mmol/L), milligrams per deciliter (mg/dL)  
**Base Unit**: mmol/L

```dart
final glucose = BloodGlucose.milligramsPerDeciliter(99);
print(glucose.inMillimolesPerLiter); // ~5.5

final high = BloodGlucose.millimolesPerLiter(7.0);
print(high.inMilligramsPerDeciliter); // ~126.1
```

### Number

Used for simple count values like step counts and floors climbed.

**Available Units**: numeric value (no conversion)  
**Base Unit**: N/A

```dart
final steps = Number(10000);
final moreSteps = steps + Number(2500);
print(moreSteps.value); // 12500
```

### Percentage

Used for body fat percentage, blood oxygen saturation, and other ratios.

**Available Units**: decimal (0.0-1.0), whole number (0-100)  
**Base Unit**: decimal

```dart
final bodyFat = Percentage.fromWhole(18.5);
print(bodyFat.asDecimal); // 0.185
print(bodyFat.asWhole);   // 18.5

final oxygen = Percentage.fromDecimal(0.98);
print(oxygen.asWhole);    // 98.0
```

### Power

Used for cycling power output, rowing power, and exercise intensity.

**Available Units**: watts, kilowatts  
**Base Unit**: watts

```dart
final power = Power.watts(250);
print(power.inKilowatts); // 0.25

final sustained = Power.kilowatts(0.3);
print(sustained.inWatts);  // 300.0
```

### Time Duration

Used for sleep duration, exercise duration, and time-based measurements.

**Available Units**: seconds, minutes, hours, Duration object  
**Base Unit**: seconds

```dart
final sleep = TimeDuration.hours(8);
print(sleep.inMinutes);  // 480.0
print(sleep.inSeconds);  // 28800.0

final nap = TimeDuration.fromDuration(Duration(minutes: 30));
final total = sleep + nap;
print(total.inHours);    // 8.5
```

### Velocity

Used for running speed, cycling speed, and movement tracking.

**Available Units**: meters per second, kilometers per hour, miles per hour  
**Base Unit**: meters per second

```dart
final speed = Velocity.kilometersPerHour(10);
print(speed.inMetersPerSecond); // ~2.78
print(speed.inMilesPerHour);    // ~6.21
```
