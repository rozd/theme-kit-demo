# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A dual-platform [Skip](https://skip.dev) app demonstrating [ThemeKit](https://github.com/rozd/theme-kit)
on iOS **and** Android from a single source tree.

Its job is not decorative. ThemeKit's Android render path is emitted into a file
(`View+ThemeStyles.swift`) that is entirely `#if os(Android)`, so ThemeKit's own Darwin-only fixture
targets compile it to nothing. **This app is that file's only real compile coverage**, and the
iOS/Android screenshot pairs in `Screenshots/` are the only check that the two platforms actually
render the same tokens. A generator template change in ThemeKit should be rebuilt here.

## Layout

```
Package.swift              SwiftPM manifest — skipstone plugin + path dep on ../theme-kit
Skip.env                   Shared config for Darwin/*.xcconfig and Android/settings.gradle.kts
theme.json                 Token config; all four categories
Sources/ThemeKitDemo/
  ContentView.swift        Tab host, theme picker, appearance picker, environment injection
  Screens/                 One screen per token category, plus the JSON round-trip screen
  DesignSystem/Theme/      Generated — do not edit by hand
Darwin/ThemeKitDemo.xcodeproj   iOS/macOS run target
Android/                        Gradle harness
Screenshots/{ios,android}/      Parity baseline
```

## Build & Run

```bash
swift build                                     # Apple-side compile
skip android build --plain                      # Android cross-compile — the important one
skip app launch --android                       # Build, install and launch on a running emulator
swift package --allow-writing-to-package-directory generate-theme   # Regenerate DesignSystem/Theme
```

iOS runs from `Darwin/ThemeKitDemo.xcodeproj`, scheme `ThemeKitDemo App`. Note that
`xcodebuild` needs `-skipPackagePluginValidation -skipMacroValidation` for the skipstone plugin,
and that `SKIP_ACTION = launch` in `Darwin/ThemeKitDemo.xcconfig` makes an Xcode run also deploy to a
running Android emulator.

## Rules for demo code

- **No `#if os(Android)` in `Sources/ThemeKitDemo/`.** The whole claim is that the call sites are
  identical; a platform conditional in app code would quietly void it.
- **No hand resolution.** Never write `theme.colors.x.resolved(colorScheme:)` in a screen — use the
  token spelling (`.foregroundStyle(.primaryColor)`). The exception is `JSONScreen`, which reads
  `@Environment(\.theme)` because encoding the theme *is* its subject.
- **Author colours with `Color(hex:)`.** Colours built any other way cannot encode on Android, which
  would break the JSON screen. Avoid `.opacity(_:)` too — `#RRGGBB` has no alpha channel.
- **Only Skip-mapped SF Symbols.** Skip maps a few hundred SF Symbols onto Material icons and renders
  everything else as a missing-glyph placeholder, which reads as a ThemeKit bug in a screenshot when
  it is not one. The mapping lives in skip-ui's `Components/Image.swift`.
- `@Environment` properties in shared views must be non-`private` — Skip requires it.

## ThemeKit dependency

`.package(path: "../theme-kit")`, deliberately: the Android render path lives on ThemeKit's
integration branch and has not been released. Switch to the versioned GitHub URL once it merges.
