import SwiftUI
import ThemeKit

// Every colour here is built with `Color(hex:)` rather than `Color(red:green:blue:)`.
// That is not a style preference: only hex-constructed colours record their spelling at
// construction, and that recording is the only thing that lets `JSONEncoder().encode(theme)`
// succeed on Android, where no colour introspection exists. The JSON tab proves it at runtime.

nonisolated extension Theme {
    static let `default` = Theme(
        colors: .`default`,
        gradients: .`default`,
        meshGradients: .`default`,
        shadows: .`default`
    )

    /// A second theme, derived from `.default` rather than written out again — this is the
    /// runtime-switching path (`copyWith`), and it works identically on both platforms.
    static let ocean = Theme.`default`.copyWith(
        colors: ThemeColors.`default`.copyWith(
            icon: .init(light: Color(hex: 0x00786B), dark: Color(hex: 0x4DD9C6)),
            primary: .init(light: Color(hex: 0x00786B), dark: Color(hex: 0x4DD9C6))
        ),
        gradients: ThemeGradients.`default`.copyWith(
            primaryGradient: .init(
                light: .init(colors: [Color(hex: 0x00786B), Color(hex: 0x003D5C)]),
                dark:  .init(colors: [Color(hex: 0x4DD9C6), Color(hex: 0x0A4C6B)])
            )
        )
    )
}

// MARK: - ThemeColors

nonisolated extension ThemeColors {
    static let `default` = ThemeColors(
        surface:   .init(light: Color(hex: 0xF7F5F2), dark: Color(hex: 0x1A1A1F)),
        onSurface: .init(light: Color(hex: 0x1A1A1F), dark: Color(hex: 0xF2F2F7)),
        icon:      .init(light: Color(hex: 0xB3541E), dark: Color(hex: 0xF2A65A)),
        primary:   .init(light: Color(hex: 0x0066CC), dark: Color(hex: 0x4DA6FF))
    )
}

// MARK: - ThemeGradients

nonisolated extension ThemeGradients {
    static let `default` = ThemeGradients(
        primaryGradient: .init(
            light: .init(colors: [Color(hex: 0x0066CC), Color(hex: 0x6633CC)]),
            dark:  .init(colors: [Color(hex: 0x4DA6FF), Color(hex: 0x33115C)])
        ),
        sunsetGradient:  .init(
            light: .init(colors: [Color(hex: 0xFF8C42), Color(hex: 0xD94E6B)]),
            dark:  .init(colors: [Color(hex: 0xB3541E), Color(hex: 0x73203A)])
        )
    )
}

// MARK: - ThemeMeshGradients

nonisolated extension ThemeMeshGradients {
    static let `default` = ThemeMeshGradients(
        primaryBackground: .init(
            light: .init(width: 2, height: 2, colors: [
                Color(hex: 0x0066CC), Color(hex: 0x6633CC),
                Color(hex: 0x00B3A6), Color(hex: 0xFF8C42),
            ]),
            dark:  .init(width: 2, height: 2, colors: [
                Color(hex: 0x33115C), Color(hex: 0x4DA6FF),
                Color(hex: 0x0A4C6B), Color(hex: 0xB3541E),
            ])
        )
    )
}

// MARK: - ThemeShadows

nonisolated extension ThemeShadows {
    static let `default` = ThemeShadows(
        // Drop shadows render on both platforms. `.inner` is data-only on Android today
        // (Skip's SwiftUI facade has no inner-shadow equivalent), so the demo does not use it.
        //
        // Note the absence of `.opacity(_:)` on these colours. The hex wire format is #RRGGBB
        // with no alpha channel, and an `.opacity()`-derived colour is not the one that was
        // cached — it would silently lose its alpha on Apple and fail to encode on Android.
        // `card` carries an explicit colour; `raised` omits one and gets the platform default.
        card:   .init(
            light: .drop(color: Color(hex: 0x8C8C99), radius: 8, x: 0, y: 4),
            dark:  .drop(color: Color(hex: 0x000000), radius: 8, x: 0, y: 4)
        ),
        raised: .init(
            light: .drop(radius: 16, x: 0, y: 8),
            dark:  .drop(radius: 16, x: 0, y: 8)
        )
    )
}
