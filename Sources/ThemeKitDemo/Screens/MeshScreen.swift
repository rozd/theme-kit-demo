import SwiftUI
import ThemeKit

/// Mesh gradient tokens — the one category that renders *differently* on the two platforms.
///
/// Skip's SwiftUI facade has no `MeshGradient`, so ThemeKit ships its own on Android: same wire
/// format, same API, but it draws a two-stop diagonal between the mesh's first and last colours.
/// The point is that a `meshGradients` config still compiles and still runs there — before this,
/// including the category made the generated `Theme` fail to build on Android at all.
struct MeshScreen: View {
    var body: some View {
        Screen(
            title: "Mesh gradients",
            subtitle: "Full mesh on Apple · degraded two-stop diagonal on Android"
        ) {
            Sample("background(.primaryBackground, in:)") {
                Text("Mesh")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.surface)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 44)
                    .background(.primaryBackground, in: RoundedRectangle(cornerRadius: 20))
            }

            Sample("RoundedRectangle().fill(.primaryBackground)") {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.primaryBackground)
                    .frame(height: 140)
            }

            Sample(
                "Same token, same call site",
                note: "The 2×2 corner colours are identical on both platforms; only the interpolation differs."
            ) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.primaryBackground)
                    .frame(height: 90)
                    .overlay {
                        Text("degraded on Android")
                            .font(.caption)
                            .foregroundStyle(.surface)
                    }
            }
        }
    }
}
