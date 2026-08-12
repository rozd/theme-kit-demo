# Parity baseline

One screenshot per screen per appearance, on each platform, from the **same** `Sources/ThemeKitDemo`
tree. Compare `ios/<screen>-<appearance>.png` against `android/<screen>-<appearance>.png`.

These are the check that ThemeKit's Android render path produces the same result as its Apple one.
The token call sites in the screens are textually identical across platforms — no `#if os(Android)`,
no manual resolution — so a difference between a pair is either an intended degradation listed below
or a bug.

| | |
|---|---|
| Screens | `colors`, `gradients`, `shadows`, `mesh`, `json` |
| Appearances | `light`, `dark` |
| Theme | `.default` (the `Ocean` button switches to a `copyWith`-derived theme at runtime) |
| Devices | iPhone 17 simulator (iOS 26.5) · `ThemeKit_Spike` AVD (Android API 36) |

## Expected differences

Everything here is a known, documented limitation — none of it is a token-resolution failure.

- **Mesh gradients.** Apple renders a true 2×2 mesh; Android renders a two-stop diagonal between the
  mesh's first and last colours. The corner colours are the same on both. Skip's SwiftUI facade has no
  `MeshGradient`, so ThemeKit ships its own.
- **Shadow rendering.** Both platforms draw drop shadows, but Compose's shadow falloff is not
  pixel-identical to Core Animation's. Inner shadows are data-only on Android and the demo avoids them.
- **SF Symbols.** Skip maps a few hundred SF Symbols onto Material icons and renders anything else as
  a missing-glyph placeholder. The demo uses only mapped names, so the icons tint correctly on both —
  but they are *Material* icons on Android, so the glyph shapes differ. This is a Skip limitation with
  nothing to do with theming.
- **System chrome.** Status bar, tab bar and button styling follow each platform's conventions. That
  is the point of Skip, not a defect.

## Regenerating

Both platforms must run the same commit. The in-app pickers (theme, appearance) exist so the two
captures are driven identically rather than through platform-specific appearance settings.

```bash
# Android — emulator must already be running
skip app launch --android

cd Screenshots/android
for mode in light:563 dark:790; do
  mname=${mode%%:*}; mx=${mode##*:}
  adb shell input tap $mx 325; adb shell sleep 1
  for t in colors:97 gradients:320 shadows:540 mesh:758 json:980; do
    adb shell input tap ${t##*:} 2226
    adb shell sleep 2
    adb exec-out screencap -p > "${t%%:*}-${mname}.png"
  done
done
```

Tap coordinates are for a 1080×2400 screen; re-derive them from a screenshot if the AVD changes.

iOS: run the `ThemeKitDemo App` scheme from `Darwin/ThemeKitDemo.xcodeproj` (add
`-skipPackagePluginValidation -skipMacroValidation` when driving `xcodebuild` directly), then capture
each tab and appearance with `xcrun simctl io booted screenshot`.
