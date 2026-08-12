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
