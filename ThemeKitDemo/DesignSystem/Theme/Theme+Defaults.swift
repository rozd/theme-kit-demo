import SwiftUI
import ThemeKit

nonisolated extension Theme {
    static let `default` = Theme(
        colors: .`default`,
        gradients: .`default`,
        meshGradients: .`default`,
        shadows: .`default`
    )
}

// MARK: - ThemeColors

nonisolated extension ThemeColors {
    static let `default` = ThemeColors(
        surface:   .init(light: .teal, dark: .pink),
        onSurface: .init(light: .black, dark: .white),
        icon:      .init(light: .white, dark: .black)
    )
}

// MARK: - ThemeMeshGradients

nonisolated extension ThemeMeshGradients {
    static let `default` = ThemeMeshGradients(
        primaryBackground: .init(
            light: .init(
                width: 3,
                height: 3,
                colors: [
                    Color(hex: 0xB8BBC5), Color(hex: 0xC9CCD4), Color(hex: 0xBEC1CA),
                    Color(hex: 0xD4D7DE), Color(hex: 0xC9CCD4), Color(hex: 0xC1C4CD),
                    Color(hex: 0xBBBEC7), Color(hex: 0xD1D4DB), Color(hex: 0xC5C8D0),
                ]
            ),
            dark: .init(
                width: 3,
                height: 3,
                colors: [
                    Color(hex: 0x3A3B46), Color(hex: 0x454851), Color(hex: 0x3E3F4A),
                    Color(hex: 0x4A4B56), Color(hex: 0x454851), Color(hex: 0x40414C),
                    Color(hex: 0x3C3D48), Color(hex: 0x484954), Color(hex: 0x43444F),
                ]
            ),
        ),
    )
}

// MARK: - ThemeShadows

nonisolated extension ThemeShadows {
    static let `default` = ThemeShadows(
        card: .init(light: .drop(radius: 4), dark: .none)
    )
}

// MARK: - ThemeGradients

nonisolated extension ThemeGradients {
    static let `default` = ThemeGradients(
        primaryGradient: .init(
            light: .init(colors: [.teal, .pink]),
            dark:  .init(colors: [.purple, .blue])
        )
    )
}
