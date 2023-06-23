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

struct PrintChart: View {
    private let entries: [PrintEntry]
    public init(entries: [PrintEntry]) {
        self.entries = entries
    }

    private var hours: [Date] {
        guard let firstEntryDate = entries.first?.date,
              let lastEntryDate = entries.last?.date
        else { return [] }

        let firstEntryHour = Calendar.current.component(.hour, from: firstEntryDate)
        guard let startDate = Calendar.current.date(bySettingHour: firstEntryHour, minute: 0, second: 0, of: firstEntryDate) else { return [] }

        let dates = sequence(first: startDate) { date in
            guard date < lastEntryDate else { return nil }
            return Calendar.current.date(byAdding: .hour, value: 1, to: date)
        }

        return Array(dates)
    }

    private var minAxisValue: Double {
        min(entries.map(\.value).min() ?? 70, 70)
    }
    private var maxAxisValue: Double {
        max(entries.map(\.value).max() ?? 120, 120)
    }

    private var axisValues: [Int] {
        Array(stride(from: minAxisValue, through: maxAxisValue, by: 10)).map(Int.init)
    }

    struct Day: Identifiable {
        let minValue: Double
        let maxValue: Double
        let id: UUID
        let startDate: Date

        init(_ entries: [PrintEntry]) {
            id = entries.first!.id
            minValue = entries.map(\.value).min()!
            maxValue = entries.map(\.value).max()!
            startDate = Calendar.current.startOfDay(for: entries.first!.date)
        }
    }

    private var days: [Day] {
        return Dictionary(grouping: entries) { entry in
            entry.formattedDate
        }.mapValues { entries -> Day in
            Day(entries)
        }.values.map { $0 }
    }

    public var body: some View {
        Chart(days) { day in
            Plot {
                BarMark(
                    x: .value("Date", day.startDate),
                    yStart: .value("Min Glucose", day.minValue),
                    yEnd: .value("Max Glucose", day.maxValue),
                    width: 8
                )
                .clipShape(Capsule())
                .foregroundStyle(Color("AccentColor"))
            }
        }.aspectRatio(16/9, contentMode: .fit)
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: 7)) { value in
                    if let date = value.as(Date.self) {
                        AxisValueLabel(format: .dateTime.day().month())

                        AxisGridLine()
                        AxisTick()
                    }
                }
            }
    }
}

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

struct PrintEntry: Identifiable {
    let date: Date
    let value: Double
    let formattedDate: String
    let formattedTime: String
    let formattedValue: String
    let id: UUID

    init(_ glucoseSample: GlucoseSample) {
        date = glucoseSample.date
        value = glucoseSample.value
//        formattedDate = date.formatted(date: .long, time: .omitted)
        formattedDate = date.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "en_US")))
        formattedTime = date.formatted(date: .omitted, time: .shortened)
        formattedValue = glucoseSample.value.formatted(.number)
        id = glucoseSample.id
    }
}

struct PrintHeaderRow: View {
    var body: some View {
        GridRow {
            Text("Date")
            Text("Time")
            Text("Glucose \(Text("(mg/dL)").font(.caption2))")
        }
        .gridColumnAlignment(.trailing)
        .font(.headline)
    }
}

struct PrintDataRow: View, Identifiable {
    private let entry: PrintEntry
    private let showDate: Bool
    init(entry: PrintEntry, showDate: Bool) {
        self.entry = entry
        self.showDate = showDate
    }

    var id: UUID { entry.id }

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
//        .padding(.top, showDate ? 18 : 0)
        .gridColumnAlignment(.trailing)
    }
}

enum PrintViewPreviews: PreviewProvider {
    private static let samples = [
        GlucoseSample(id: UUID(), value: 120, date: Date()),
        GlucoseSample(id: UUID(), value: 90, date: Date(timeIntervalSinceNow: -5200)),
        GlucoseSample(id: UUID(), value: 120, date: Date(timeIntervalSinceNow: -86000)),
        GlucoseSample(id: UUID(), value: 90, date: Date(timeIntervalSinceNow: -89000))
    ]
    static var previews: some View {
        PrintView(entries: samples.map(PrintEntry.init(_:)))
            .previewLayout(.fixed(width: 612, height: 792))
    }
}
