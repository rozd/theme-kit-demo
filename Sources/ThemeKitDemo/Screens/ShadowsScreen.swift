import SwiftUI
import ThemeKit

/// Shadow tokens, including the composing form.
///
/// `.cardSurface.card` is the interesting one: a shadow token chained onto a *style* token, which
/// only resolves because the modifier's parameter is a protocol-constrained generic — `ShapeStyle`
/// on Apple, ThemeKit's generated `AndroidShapeStyleAdapter` on Android. Chaining onto a non-theme
/// style (`.red.card`) is Apple-only for now; letting `Color` conform on Android would make
/// `.foregroundStyle(.red)` ambiguous with Skip's own modifier.
struct ShadowsScreen: View {
    var body: some View {
        Screen(
            title: "Shadows",
            subtitle: "Standalone tokens and the .cardSurface.card composing form"
        ) {
            Sample("background(.cardSurface.card, in:)") {
                Text("Card")
                    .font(.headline)
                    .foregroundStyle(.onSurface)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(.cardSurface.card, in: RoundedRectangle(cornerRadius: 16))
                    .padding(6)
            }

            Sample("background(.cardSurface.raised, in:)", note: "Larger radius, default shadow colour") {
                Text("Raised")
                    .font(.headline)
                    .foregroundStyle(.onSurface)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(.cardSurface.raised, in: RoundedRectangle(cornerRadius: 16))
                    .padding(10)
            }

            Sample("RoundedRectangle().fill(.primaryColor.card)") {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.primaryColor.card)
                    .frame(height: 90)
                    .padding(6)
            }

            Sample(
                "The shadow token on its own",
                note: "Inner shadows are data-only on Android, so this demo uses drop shadows throughout."
            ) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.cardSurface)
                    .frame(height: 60)
                    .background(.cardSurface.raised, in: RoundedRectangle(cornerRadius: 16))
                    .padding(10)
            }
        }
    }
}
