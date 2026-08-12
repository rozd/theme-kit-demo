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
        surface:   .init(light: <#light#>, dark: <#dark#>),
        onSurface: .init(light: <#light#>, dark: <#dark#>),
        icon:      .init(light: <#light#>, dark: <#dark#>),
        accent:    .init(light: <#light#>, dark: <#dark#>)
    )
}

// MARK: - ThemeGradients

nonisolated extension ThemeGradients {
    static let `default` = ThemeGradients(
        primaryGradient: .init(
            light: .init(colors: [<#color#>, <#color#>]),
            dark:  .init(colors: [<#color#>, <#color#>])
        ),
        sunsetGradient:  .init(
            light: .init(colors: [<#color#>, <#color#>]),
            dark:  .init(colors: [<#color#>, <#color#>])
        )
    )
}

// MARK: - ThemeMeshGradients

nonisolated extension ThemeMeshGradients {
    static let `default` = ThemeMeshGradients(
        primaryBackground: .init(
            light: .init(width: 2, height: 2, colors: [<#color#>, <#color#>, <#color#>, <#color#>]),
            dark:  .init(width: 2, height: 2, colors: [<#color#>, <#color#>, <#color#>, <#color#>])
        )
    )
}

// MARK: - ThemeShadows

nonisolated extension ThemeShadows {
    static let `default` = ThemeShadows(
        card:   .init(light: <#light#>, dark: <#dark#>),
        raised: .init(light: <#light#>, dark: <#dark#>)
    )
}
