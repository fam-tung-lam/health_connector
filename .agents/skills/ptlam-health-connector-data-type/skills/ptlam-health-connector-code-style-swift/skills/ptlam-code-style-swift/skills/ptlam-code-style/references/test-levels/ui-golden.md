# UI Golden Testing

Use a UI golden test when the risk lies in the rendered appearance of one stable
interface state. A golden is an approved image baseline compared with a new
render.

## Rules

- Render the smallest UI surface that proves the visual contract.
- Reach the target state through public inputs rather than internal mutation.
- Fix the viewport, pixel ratio, fonts, theme, locale, text scale, time,
  randomness, and animation state that affect pixels.
- Replace network images and other uncontrolled resources with deterministic
  fixtures at their boundary.
- Keep separate baselines only for intentional renderer or platform differences.
- Assert interaction, semantics, and non-visual behavior at another level. Pixel
  comparison does not establish them.
- Inspect the visual diff before accepting a new baseline. Regenerate only the
  baselines whose intended appearance changed.
- Keep the baseline change in the same review as the UI change that requires it.

## Exit criteria

- The baseline records an intentional, reviewable visual contract.
- A failure identifies a visual difference rather than an uncontrolled
  environment change.
- The same appearance is not asserted by a broader or duplicate golden.
