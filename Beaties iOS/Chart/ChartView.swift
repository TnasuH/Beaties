import Charts
import HealthConnect
import SwiftUI

public struct ChartView: View {
    private let entries: [ChartEntry]
    public init(samples: [GlucoseSample]) {
        self.entries = samples
            .sorted { $0.date < $1.date }
            .map(ChartEntry.init(sample:))
    }

    private var hours: [Date] {
        let todayStart = Calendar.current.startOfDay(for: Date())
        let morning = Calendar.current.date(bySetting: .hour, value: 6, of: todayStart)!
        let noon = Calendar.current.date(bySetting: .hour, value: 12, of: todayStart)!
        let evening = Calendar.current.date(bySetting: .hour, value: 18, of: todayStart)!
        let todayEnd = Calendar.current.date(byAdding: .day, value: 1, to: todayStart)!
        return [todayStart, morning, noon, evening, todayEnd]
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
        .chartXAxis {
            AxisMarks(values: hours) {
                AxisGridLine().foregroundStyle(.tertiary)
                AxisValueLabel(format: .dateTime.hour())
                    .font(.system(size: 10).weight(.bold))
                    .foregroundStyle(.primary)
            }
        }
        .chartYScale(domain: minAxisValue...maxAxisValue)
        .chartYAxis {
            AxisMarks(values: axisValues) {
                AxisGridLine()
                    .foregroundStyle(.secondary)
                AxisValueLabel()
                    .foregroundStyle(.primary)
                    .font(.system(size: 9).weight(.bold))
            }
        }
    }
}

#Preview {
    ChartView(samples: PreviewHealthRepository().samplesFromToday())
        .tint(Color.orange)
        .aspectRatio(16/9, contentMode: .fit)
        .scenePadding(.horizontal)
}
