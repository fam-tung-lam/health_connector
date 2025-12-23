# Core API

The main SDK interface for health data operations.

## HealthConnector

The central class for all health data operations:

- **Permission Management**: Request and check permissions
- **Reading Data**: Query health records with filtering and pagination
- **Writing Data**: Store health measurements
- **Aggregation**: Calculate sums, averages, min/max values
- **Feature Status**: Check platform capabilities

## Request-Response Pattern

All operations use strongly-typed request/response objects
for type-safe data handling with compile-time guarantees.
