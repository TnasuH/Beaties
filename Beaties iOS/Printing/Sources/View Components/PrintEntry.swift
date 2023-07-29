import PhoneHealthConnect
import SwiftUI

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
        formattedDate = date.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "en_US")))
        formattedTime = date.formatted(date: .omitted, time: .shortened)
        formattedValue = glucoseSample.value.formatted(.number)
        id = glucoseSample.id
    }
}
