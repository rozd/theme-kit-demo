import SwiftUI
import ThemeKit

enum ContentTab: String, Hashable {
    case colors, gradients, shadows, mesh, json
}

/// The demo's root.
///
/// Two controls sit above every screen because they are what the screens are *for*: the theme
/// picker exercises runtime switching (`copyWith`-derived themes), and the appearance picker
/// forces light/dark so a parity screenshot pair can be captured identically on both platforms
/// without reaching for `adb shell cmd uimode` on one and the simulator UI on the other.
struct ContentView: View {
    @AppStorage("tab") var tab = ContentTab.colors
    @AppStorage("theme") var themeName = ThemeChoice.default.rawValue
    @AppStorage("appearance") var appearance = ""

    var theme: Theme {
        ThemeChoice(rawValue: themeName)?.theme ?? .default
    }

    var body: some View {
        VStack(spacing: 0) {
            ThemeControls(themeName: $themeName, appearance: $appearance)

            TabView(selection: $tab) {
                ColorsScreen()
                    .tabItem { Label("Colors", systemImage: "heart.fill") }
                    .tag(ContentTab.colors)

                GradientsScreen()
                    .tabItem { Label("Gradients", systemImage: "star.fill") }
                    .tag(ContentTab.gradients)

                ShadowsScreen()
                    .tabItem { Label("Shadows", systemImage: "bookmark.fill") }
                    .tag(ContentTab.shadows)

                MeshScreen()
                    .tabItem { Label("Mesh", systemImage: "chart.bar.xaxis") }
                    .tag(ContentTab.mesh)

                JSONScreen()
                    .tabItem { Label("JSON", systemImage: "list.bullet") }
                    .tag(ContentTab.json)
            }
        }
        // The one injection point. Everything below reads tokens as if they were built in.
        .environment(\.theme, theme)
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}

enum ThemeChoice: String, CaseIterable {
    case `default`
    case ocean

    var theme: Theme {
        switch self {
        case .default: return .default
        case .ocean: return .ocean
        }
    }

    var title: String {
        switch self {
        case .default: return "Default"
        case .ocean: return "Ocean"
        }
    }
}

/// Plain buttons rather than a segmented `Picker`: both platforms render buttons the same way,
/// which keeps the parity screenshots comparable.
struct ThemeControls: View {
    @Binding var themeName: String
    @Binding var appearance: String

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                ForEach(ThemeChoice.allCases, id: \.rawValue) { choice in
                    Button(choice.title) {
                        themeName = choice.rawValue
                    }
                    .buttonStyle(.bordered)
                    .disabled(themeName == choice.rawValue)
                }
            }
            HStack(spacing: 8) {
                appearanceButton("System", "")
                appearanceButton("Light", "light")
                appearanceButton("Dark", "dark")
            }
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        // A theme token styling the chrome itself, via the ordinary spelling.
        .background(.surface)
    }

    func appearanceButton(_ title: String, _ value: String) -> some View {
        Button(title) {
            appearance = value
        }
        .buttonStyle(.bordered)
        .disabled(appearance == value)
    }
}
