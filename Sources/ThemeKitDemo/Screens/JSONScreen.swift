import Foundation
import SkipFuse
import SwiftUI
import ThemeKit

/// Encodes the live theme, decodes it back, and reports what happened — on device.
///
/// This screen exists because "theme JSON round-trips on Android" was previously a claim backed
/// only by a logcat line during a spike. Here it is a visible result on both platforms, and it
/// fails loudly rather than silently if the hex cache ever stops doing its job.
struct JSONScreen: View {

    /// Skip requires `@Environment` properties in shared views to be non-private.
    @Environment(\.theme) var theme: Theme

    var body: some View {
        Screen(
            title: "JSON round-trip",
            subtitle: "encode → decode → encode, evaluated on this device"
        ) {
            let result = RoundTrip(theme: theme)

            Sample("Result") {
                VStack(alignment: .leading, spacing: 4) {
                    row("encode", result.encodeSummary)
                    row("decode equals original", result.decodeSummary)
                    row("byte-stable re-encode", result.stabilitySummary)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.surface.card, in: RoundedRectangle(cornerRadius: 12))
                .padding(4)
            }

            Sample("Payload", note: "First 700 characters") {
                Text(result.excerpt)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(.surface.raised, in: RoundedRectangle(cornerRadius: 12))
                    .padding(4)
            }
        }
        .onAppear {
            let result = RoundTrip(theme: theme)
            logger.info("[demo] encode=\(result.encodeSummary) decode=\(result.decodeSummary) stable=\(result.stabilitySummary)")
        }
    }

    func row(_ label: String, _ value: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label)
                .font(.caption)
                .frame(width: 160, alignment: .leading)
            Text(value)
                .font(.caption)
                .bold()
        }
        .foregroundStyle(.onSurface)
    }
}

/// Plain value type so the work is identical on both platforms and easy to log.
struct RoundTrip {
    let encodeSummary: String
    let decodeSummary: String
    let stabilitySummary: String
    let excerpt: String

    init(theme: Theme) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        guard let data = try? encoder.encode(theme) else {
            // On Android this is what a theme built with Color(red:green:blue:) would produce:
            // those colours never recorded a hex spelling, so there is nothing to encode.
            self.encodeSummary = "failed"
            self.decodeSummary = "n/a"
            self.stabilitySummary = "n/a"
            self.excerpt = "Encoding failed. On Android only colours built with Color(hex:) can encode."
            return
        }

        self.encodeSummary = "ok, \(data.count) bytes"

        guard let decoded = try? JSONDecoder().decode(Theme.self, from: data) else {
            self.decodeSummary = "failed"
            self.stabilitySummary = "n/a"
            self.excerpt = String(decoding: data.prefix(700), as: UTF8.self)
            return
        }

        self.decodeSummary = decoded == theme ? "yes" : "no"

        let reencoded = try? encoder.encode(decoded)
        self.stabilitySummary = reencoded == data ? "yes" : "no"
        self.excerpt = String(decoding: data.prefix(700), as: UTF8.self)
    }
}
