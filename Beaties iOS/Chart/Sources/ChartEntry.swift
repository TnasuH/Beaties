import Foundation
import PhoneHealthConnect

struct ChartEntry: Identifiable {
    let id: UUID
    let value: Double
    let date: Date

    init(sample: GlucoseSample) {
        self.init(id: sample.id, value: sample.value, date: sample.date)
    }

    init(id: UUID = UUID(), value: Double, date: Date) {
        self.id = id
        self.value = value
        self.date = date
    }
}
