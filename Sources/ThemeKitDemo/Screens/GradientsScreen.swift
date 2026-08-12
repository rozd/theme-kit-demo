import SwiftUI
import ThemeKit

/// Gradient tokens.
///
/// Worth knowing: on Android these render through Skip's `AnyGradient`, whose Compose bridge is
/// a top-to-bottom linear gradient — which is exactly what SwiftUI's `Gradient: ShapeStyle`
/// conformance does on Apple. Parity here is free rather than approximated.
struct GradientsScreen: View {
    var body: some View {
        Screen(
            title: "Gradients",
            subtitle: "The same token in a background, a fill and a stroke"
        ) {
            Sample("background(.primaryGradient, in:)") {
                Text("Primary gradient")
                    .font(.headline)
                    .foregroundStyle(.surface)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.primaryGradient, in: RoundedRectangle(cornerRadius: 16))
            }

            Sample("RoundedRectangle().fill(.sunsetGradient)") {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.sunsetGradient)
                    .frame(height: 90)
            }

            Sample("stroke(.primaryGradient, lineWidth: 10)") {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.primaryGradient, lineWidth: 10)
                    .frame(height: 90)
            }

            Sample("foregroundStyle(.sunsetGradient)") {
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.sunsetGradient)
            }
        }
    }
}
