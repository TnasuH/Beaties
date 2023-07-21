import HealthConnect
import SwiftUI

struct ListEntry: Identifiable {
    let date: Date
    let value: Double
    let formattedDate: String
    let formattedTime: String
    let formattedValue: String
    let id: UUID
    let isFirstEntry: Bool

    init(_ glucoseSample: GlucoseSample, isFirstEntry: Bool) {
        date = glucoseSample.date
        value = glucoseSample.value
        formattedDate = date.formatted(.dateTime.day().month().locale(Locale.current))
        formattedTime = date.formatted(date: .omitted, time: .shortened)
        formattedValue = glucoseSample.value.formatted(.number)
        id = glucoseSample.id
        self.isFirstEntry = isFirstEntry
    }
}
