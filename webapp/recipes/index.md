# App recipes

Complete flows for the app categories that most often integrate health data. Each recipe is written as working code you can adapt rather than a fragment to assemble.

If you have not run a read yet, start with [Your first integration](/guide/quickstart) — these recipes assume you have a `connector` and know how permissions work.

<NextSteps
  title="Recipes"
  :links="[
    { text: 'Nutrition & hydration', link: '/recipes/nutrition', description: 'Log meals with macros, track water, and summarise a day.' },
    { text: 'Sleep tracking', link: '/recipes/sleep', description: 'The one feature that needs a different read path per platform.' },
    { text: 'Mindfulness & behavioral health', link: '/recipes/mindfulness', description: 'Meditation and breathing sessions, plus weekly stats.' },
    { text: 'Fitness & activity tracking', link: '/recipes/fitness', description: 'Runs with laps, segments, and GPS routes.' },
  ]"
/>

## Patterns they share

**Request permissions at the point of use.** Every recipe requests only what the specific action needs, immediately before doing it. That is both better for grant rates and clearer to read.

**Write once, read typed.** Requests built from a `HealthDataType` return the matching record type, so none of these examples contain a cast.

**Aggregate rather than fold.** Where a recipe needs a total, it asks the platform for one instead of summing records in Dart. See [Aggregate data](/guide/tasks/aggregate).

**Handle the platform split explicitly.** Where a flow touches something Android-only or iOS-only, the recipe says so rather than quietly working on one platform.

## Choosing your data types

The 140 supported types are searchable by category and platform in the [data type explorer](/reference/health-data-types). Before committing to a feature, check that every type it needs is available on both platforms you ship — nutrition in particular is modelled differently by each store.
