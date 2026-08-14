---
outline: false
---

# Health data types

Every data type the SDK supports, with its typed constant, aggregation metrics, platform availability, and the native API it maps to. Search by name, description, constant, or native identifier.

<DataTypeExplorer />

## How to read an entry

**The constant** is what you use everywhere — `HealthDataType.steps` gives you the permissions, the read request, the delete request, and the aggregates for that type. Copy it with the button next to it.

**Aggregation** lists the metrics that type actually supports. If a metric is not listed, the corresponding method does not exist on the type, so the mistake is caught at compile time rather than at runtime. See [Aggregate data](/guide/tasks/aggregate).

**Platform chips** show where the type is available as a discrete `HealthDataType`. Nutrition is the case that surprises people: HealthKit exposes each nutrient as its own identifier, while Health Connect models the same values as fields on a single `NutritionRecord`. A nutrient marked HealthKit-only is still writable on Android through `NutritionRecord` — it just has no standalone Health Connect data type. See [the nutrition recipe](/recipes/nutrition).

**Native APIs** link to Google's and Apple's own documentation for the underlying record or identifier, which is where to look when you need the platform's exact semantics for a measurement.

::: tip Verify availability before promising a feature
Filter by **Both** to see only the types that exist as first-class data types on Health Connect and HealthKit alike. Anything outside that set needs a platform branch or a documented gap.
:::

<NextSteps
  :links="[
    { text: 'Data types & capabilities', link: '/guide/concepts/data-types', description: 'How a type carries permissions, requests, and capabilities.' },
    { text: 'Exercise types', link: '/reference/exercise-types', description: 'The 96 workout types, catalogued separately.' },
    { text: 'Annotations', link: '/reference/annotations', description: 'Reading the platform and OS-version constraints.' },
  ]"
/>
