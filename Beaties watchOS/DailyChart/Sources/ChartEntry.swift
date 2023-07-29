import Foundation
import WatchHealthConnect

public struct ChartEntry: Identifiable {
    public let id: UUID
    let value: Double
    let date: Date

    public init(sample: GlucoseSample) {
        self.init(id: sample.id, value: sample.value, date: sample.date)
    }

    internal init(id: UUID = UUID(), value: Double, date: Date) {
        self.id = id
        self.value = value
        self.date = date
    }
}
