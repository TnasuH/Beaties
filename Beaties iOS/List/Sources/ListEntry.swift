import PhoneHealthConnect
import SwiftUI

struct ListEntry: Identifiable {
    let date: Date
    let value: Double
//    private let formattedDate: String
//    private let formattedTime: String
    let formattedDateTime: String
    let formattedValue: String
    let id: UUID

    init(_ glucoseSample: GlucoseSample, isFirstEntry: Bool, isSingleDay: Bool) {
        date = glucoseSample.date
        value = glucoseSample.value
        let formattedDate = date.formatted(.dateTime.day().month().locale(Locale.current))
        let formattedTime = date.formatted(date: .omitted, time: .shortened)
        if isSingleDay {
            formattedDateTime = formattedTime
        } else {
            formattedDateTime = "\(formattedDate) at \(formattedTime)"
        }
        formattedValue = "\(glucoseSample.value.formatted(.number))\(isFirstEntry ? " mg/dL" : "")"
        id = glucoseSample.id
    }
}
