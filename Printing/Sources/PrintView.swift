import Charts
import HealthConnect
import SwiftUI

struct PrintView: View {
    private let entries: [PrintEntry]
    init(entries: [PrintEntry]) {
        self.entries = entries
    }

    var body: some View {
        VStack(spacing: 16) {
            PrintChart(entries: entries)
            PrintTable(entries: entries)
            Spacer()
        }
        .padding(36)
        .frame(width: 612)
        .frame(minHeight: 792)
        .overlay(alignment: .bottom) {
            Text("Measured by \(Text("[beaties.app](https://beaties.app)").underline())")
                .font(.system(size: 9)).padding(9)
        }
        .accentColor(Color("Primary"))
    }
}

#Preview {
    PrintView(
        entries: [
            GlucoseSample(id: UUID(), value: 120, date: Date()),
            GlucoseSample(id: UUID(), value: 90, date: Date(timeIntervalSinceNow: -5200)),
            GlucoseSample(id: UUID(), value: 120, date: Date(timeIntervalSinceNow: -86000)),
            GlucoseSample(id: UUID(), value: 90, date: Date(timeIntervalSinceNow: -89000))
        ].map(PrintEntry.init(_:))
    ).previewLayout(.fixed(width: 612, height: 792))
}
