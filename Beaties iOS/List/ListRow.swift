import HealthConnect
import SwiftUI

struct ListRow: View {
    private let entry: ListEntry
    init(_ entry: ListEntry) {
        self.entry = entry
    }

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("\(entry.formattedValue)\(entry.isFirstEntry ? " mg/dL" : "")")
            Spacer()
            Text("\(entry.formattedDate) at \(entry.formattedTime)")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    List {
        Group {
            ListRow(ListEntry(GlucoseSample(id: UUID(), value: 120, date: Date()), isFirstEntry: true))
            ListRow(ListEntry(GlucoseSample(id: UUID(), value: 80, date: Date()), isFirstEntry: false))
        }
    }
}
