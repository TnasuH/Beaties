import Charts
import SwiftUI

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
                    AxisValueLabel(format: .dateTime.day().month())
                    AxisGridLine()
                    AxisTick()
                }
            }
    }
}
