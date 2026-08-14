---
outline: false
---

# Exercise types

The activities `ExerciseSessionRecord.exerciseType` accepts. Availability differs between the two stores, so check before hard-coding one.

<ExerciseTypeExplorer />

## Notes

**Filter by Both** when a feature must behave identically on Android and iOS. Types available on only one store still compile — they throw `UnsupportedOperationException` at runtime on the other one.

**`ExerciseType.other` is the safe fallback.** When the activity your app tracks has no exact match, or has one on only one platform, record it as `other` with a descriptive `title` rather than picking a near-miss type. The title is what users see in the native health apps.

**Segments describe what happened inside a session.** `ExerciseSegmentType` is a separate vocabulary covering sets and movements such as bench press. Segment weight has an additional device requirement on Android — see [SDK Extension 21](/reference/annotations#exercise-segment-weight-and-sdk-extension-21).

<NextSteps
  :links="[
    { text: 'Fitness recipes', link: '/recipes/fitness', description: 'A complete run with laps, segments, and a route.' },
    { text: 'Exercise routes', link: '/guide/tasks/exercise-routes', description: 'Route permissions and lazy loading.' },
    { text: 'Health data types', link: '/reference/health-data-types', description: 'The full data type catalog.' },
  ]"
/>
