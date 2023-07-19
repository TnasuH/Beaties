import SwiftUI

struct PrintTable: View {
    private let rows: [PrintDataRow]
    init(entries: [PrintEntry]) {
        let grouped = Dictionary(grouping: entries) { entry in
            entry.formattedDate
        }
        let partiallySorted = grouped.mapValues { entries in
            entries.sorted { lhs, rhs in
                lhs.date > rhs.date
            }
        }
        let sorted = partiallySorted.sorted { lhs, rhs in
            lhs.value.first!.date > rhs.value.first!.date
        }

        self.rows = sorted.flatMap { section in
            var (_, entries) = section
            let firstEntry = entries.removeFirst()
            let firstRow = PrintDataRow(entry: firstEntry, showDate: true)
            let otherRows = entries.map {
                PrintDataRow(entry: $0, showDate: false)
            }
            return [firstRow] + otherRows
        }
    }

    var body: some View {
        Grid(horizontalSpacing: 36, verticalSpacing: 4) {
            PrintHeaderRow()
            Divider().gridCellUnsizedAxes(.horizontal)
            ForEach(rows) { $0 }
        }.gridColumnAlignment(.trailing)
    }
}
