import SwiftUI
import ThemeKit

/// Colour tokens through every modifier ThemeKit overloads on Android.
///
/// `.primaryColor` is the `style` override from theme.json — the token is named `primary`, but
/// `.primary` is already taken by SwiftUI, so the accessor is spelled `primaryColor`.
struct ColorsScreen: View {
    var body: some View {
        Screen(
            title: "Colors",
            subtitle: "foregroundStyle · background · border · fill · stroke"
        ) {
            // The case the Android-native path exists for.
            //
            // `.colorScheme(_:)` swaps MaterialTheme on Android without writing the SwiftUI
            // environment, so anything resolving a token from `@Environment(\.colorScheme)`
            // cannot see a subtree override. Handing the token to Compose unresolved lets
            // Compose read MaterialTheme itself, at the draw call.
            //
            // `Color.red` is the control: SkipUI's palette colours consult the device setting
            // via isSystemInDarkTheme(), so the built-in swatch is expected NOT to flip while
            // the ThemeKit token does. On Apple both flip, which is the parity baseline.
            Sample("subtree .colorScheme(.dark) — token vs Color.red") {
                HStack(spacing: 28) {
                    LabelledSwatches("outer")
                    LabelledSwatches("dark subtree")
                        .colorScheme(.dark)
                }
            }

            // Symbol choice matters for parity: Skip maps a few hundred SF Symbols onto Material
            // icons and renders anything else as a missing-glyph placeholder, so this demo sticks
            // to mapped names. That is a Skip limitation, unrelated to token resolution.
            Sample("foregroundStyle(.icon)") {
                HStack(spacing: 12) {
                    Image(systemName: "heart.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "bell.fill")
                }
                .font(.largeTitle)
                .foregroundStyle(.icon)
            }

            Sample("background(.primaryColor, in:)") {
                Text("Primary")
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .foregroundStyle(.surface)
                    .background(.primaryColor, in: RoundedRectangle(cornerRadius: 12))
            }

            Sample("border(.primaryColor, width: 3)") {
                Text("Bordered")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .foregroundStyle(.onSurface)
                    .border(.primaryColor, width: 3)
            }

            // Still on the environment-driven path even in native mode: Compose gives a style no
            // channel to contribute a shadow, so a shadow token cannot be handed over unresolved.
            Sample(".icon.card — shadow composition still resolves in Swift") {
                Text("Shadowed")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .foregroundStyle(.onSurface)
                    .background(.cardSurface.card, in: RoundedRectangle(cornerRadius: 12))
            }

            Sample("Circle().fill(.icon) · stroke(.primaryColor)") {
                HStack(spacing: 16) {
                    Circle()
                        .fill(.icon)
                        .frame(width: 64, height: 64)
                    Circle()
                        .stroke(.primaryColor, lineWidth: 6)
                        .frame(width: 64, height: 64)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.primaryColor)
                        .frame(width: 64, height: 64)
                }
            }
        }
    }
}

/// A ThemeKit token swatch beside a built-in `Color.red`, so one screenshot shows both.
struct LabelledSwatches: View {
    let label: String

    init(_ label: String) {
        self.label = label
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.onSurface)
            HStack(spacing: 10) {
                Circle()
                    .fill(.icon)
                    .frame(width: 44, height: 44)
                Circle()
                    .fill(Color.red)
                    .frame(width: 44, height: 44)
            }
        }
    }
}
