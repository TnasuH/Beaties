import PhoneHealthConnect
import SwiftUI

public struct EntryView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            EntryForm(
                date: $date,
                glucose: $glucose,
                notes: $notes,
                mealTime: $mealTime
            ).toolbar {
                EntryToolbarContent(glucose: $glucose) {
                    guard let glucoseValue = Double(glucose) else { return }
                    try? await repository.addGlucoseValue(glucoseValue)
                }
            }
        }
    }

    @Environment(\.healthRepository) private var repository
    @State private var date = Date()
    @State private var glucose = ""
    @State private var notes = ""
    @State private var mealTime = MealTime.unspecified
}

#Preview {
    EntryView()
}
