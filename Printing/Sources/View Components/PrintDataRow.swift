import SwiftUI

struct PrintDataRow: View, Identifiable {
    private let entry: PrintEntry
    private let showDate: Bool
    init(entry: PrintEntry, showDate: Bool) {
        self.entry = entry
        self.showDate = showDate
    }

    var id: UUID { entry.id }
    var formattedDate: String { entry.formattedDate }
    var formattedTime: String { entry.formattedTime }
    var formattedValue: String { entry.formattedValue }

    var body: some View {
        GridRow {
            if showDate {
                Text(entry.formattedDate).monospacedDigit()
            } else {
                Text("")
            }
            Text(entry.formattedTime).monospacedDigit()
            Text(entry.formattedValue).monospacedDigit()
        }
        .gridColumnAlignment(.trailing)
    }
}
