# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an iOS SwiftUI demo app for the [ThemeKit](https://github.com/rozd/theme-kit) Swift package. ThemeKit provides a native-feeling theme system where design tokens (colors, gradients, shadows) resolve automatically for light/dark color schemes and are used identically to built-in SwiftUI styles (e.g., `.foregroundStyle(.primaryColor)`).

## Build & Test Commands

This is an Xcode project (not Swift Package Manager). Use `xcodebuild` from the CLI:

```bash
# Build
xcodebuild -project ThemeKitDemo.xcodeproj -scheme ThemeKitDemo -destination 'platform=iOS Simulator,name=iPhone 16' build

# Run all unit tests
xcodebuild -project ThemeKitDemo.xcodeproj -scheme ThemeKitDemo -destination 'platform=iOS Simulator,name=iPhone 16' test

# Run a single test (Swift Testing framework)
xcodebuild -project ThemeKitDemo.xcodeproj -scheme ThemeKitDemo -destination 'platform=iOS Simulator,name=iPhone 16' test -only-testing:ThemeKitDemoTests/ThemeKitDemoTests/example
```

## Architecture & Key Patterns

### Swift Concurrency Settings

The project enables **strict concurrency by default**: `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` and `SWIFT_APPROACHABLE_CONCURRENCY = YES`. All types are implicitly `@MainActor`-isolated unless explicitly opted out with `nonisolated`.

### Test Frameworks

- **Unit tests** (`ThemeKitDemoTests/`): Swift Testing framework (`import Testing`, `@Test` macro)
- **UI tests** (`ThemeKitDemoUITests/`): XCTest framework (`import XCTest`)

### ThemeKit Integration Pattern

ThemeKit's core type is `ThemeAdaptiveStyle<Style: ShapeStyle>`, which conforms to `ShapeStyle` and resolves light/dark variants from the SwiftUI environment. The typical integration:

1. Define a `theme.json` config with token names for colors, gradients, and shadows
2. Run the ThemeKit Xcode command plugin to generate theme types and `ShapeStyle` extensions
3. Provide default values in a `Theme+Default.swift` extension
4. Inject the theme via `.environment(\.theme, theme)` at the app root
5. Use tokens as standard SwiftUI styles: `.foregroundStyle(.primaryColor)`, `.fill(.surface)`

### Deployment Target

iOS 26.2+ (Xcode 26.3 beta toolchain), Swift 5.0 language version.
