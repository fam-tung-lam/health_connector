# Example

Example app demonstrating the unified `HealthConnector` API that works across both
Android Health Connect and iOS HealthKit.

## What It Demonstrates

This example showcases all public API methods of the `HealthConnector` class:

- **Platform Status** - Check health platform availability
- **Permissions** - Request and manage health data permissions
- **Feature Status** - Check platform feature availability
- **Read Operations** - Read single records and paginated record lists
- **Write Operations** - Write single and multiple records
- **Update Operations** - Update existing health records
- **Aggregation** - Aggregate health data over time ranges
- **Delete Operations** - Delete records by time range or IDs

## Running the Example

```bash
cd packages/health_connector/example
flutter run
```

## Learn More

For detailed documentation, see the [main package README](../../README.md).
