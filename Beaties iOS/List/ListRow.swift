import HealthConnect
import SwiftUI

struct ListRow: View {
    private let entry: ListEntry
    init(_ entry: ListEntry) {
        self.entry = entry
    }

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(entry.formattedValue)
            Spacer()
            Text(entry.formattedDateTime)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    List {
        Group {
            ListRow(ListEntry(GlucoseSample(id: UUID(), value: 120, date: Date()), isFirstEntry: true, isSingleDay: true))
            ListRow(ListEntry(GlucoseSample(id: UUID(), value: 80, date: Date()), isFirstEntry: false, isSingleDay: true))
        }
    }
}
