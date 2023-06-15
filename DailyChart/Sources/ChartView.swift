import Charts
import SwiftUI

public struct ChartView: View {
    private let entries: [ChartEntry]
    public init(entries: [ChartEntry]) {
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

    public var body: some View {
        Chart(entries) { entry in
            LineMark(
                x: .value("Date", entry.date),
                y: .value("Value", entry.value)).lineStyle(StrokeStyle(lineWidth: 5, lineJoin: .round))
                .interpolationMethod(.catmullRom)

            PointMark(
                x: .value("Date", entry.date),
                y: .value("Value", entry.value)).lineStyle(StrokeStyle(lineWidth: 5, lineJoin: .round))
        }
        .foregroundStyle(Color.white)
        .chartXAxis {
            AxisMarks(values: hours) {
                AxisGridLine()
                AxisValueLabel(format: .dateTime.hour())
            }
        }
        .chartYScale(domain: minAxisValue...maxAxisValue)
        .chartYAxis {
            AxisMarks(values: axisValues)
        }
    }
}

enum ChartViewPreviews: PreviewProvider {
    static var previews: some View {
        ChartView(entries: [
            ChartEntry(value: 150, date: .init(timeIntervalSinceNow: -7200)),
            ChartEntry(value: 96, date: .init(timeIntervalSinceNow: -3600)),
            ChartEntry(value: 98, date: .init(timeIntervalSinceNow: 0))
        ])
    }
}
