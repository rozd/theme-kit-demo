import SwiftUI
import ThemeKit

/// Shared chrome so each screen file is nothing but token usage.
///
/// Note what is *not* here: no `@Environment(\.theme)`, no `#if os(Android)`, no resolution
/// helper. Tokens are applied with the same modifiers as SwiftUI's own styles, which is the
/// single claim this whole app exists to demonstrate.
struct Screen<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder let content: Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title2)
                        .bold()
                    Text(subtitle)
                        .font(.caption)
                }
                .foregroundStyle(.onSurface)

                content
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.surface, ignoresSafeAreaEdges: .all)
    }
}

/// A labelled row. The label reads `onSurface`; the swatch is supplied by the caller.
struct Sample<Content: View>: View {
    let label: String
    let note: String?
    @ViewBuilder let content: Content

    init(_ label: String, note: String? = nil, @ViewBuilder content: () -> Content) {
        self.label = label
        self.note = note
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.onSurface)
            content
            if let note {
                Text(note)
                    .font(.caption2)
                    .foregroundStyle(.onSurface)
            }
        }
    }
}
