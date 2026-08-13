# Phase 2 — subtree colour-scheme evidence

Emulator `emulator-5554` (API 36), device forced to light mode via
`adb shell cmd uimode night no`, so the ambient context differs from the
`.colorScheme(.dark)` subtree in the Colors screen's first sample.

| File | What it shows |
|---|---|
| `android-subtree-override.png` | Built **with** ThemeKit's `androidNativeShapeStyle` flag |
| `android-subtree-override-NEGATIVE.png` | Built **without** it |
| `android-colors.png` | The same screen with the app in dark appearance |
| `android-native-confirm.png` | Re-confirmation after an emulator restart |

The first two are the point: they are **identical**. The theme token flips
between the ambient context and the dark subtree in both, which is what
retired the feature — the Phase 1 render path already handled the case the
feature was built to fix.

`Color.red` does *not* flip in either, which is a separate and still-live
finding: SkipUI's palette colours resolve through `isSystemInDarkTheme()`
rather than the surrounding `MaterialTheme`. See `skip-ui`'s own
`// TODO: EnvironmentValues.shared.colorMode` in `Color.swift`.
