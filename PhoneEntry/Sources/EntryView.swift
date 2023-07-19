import SwiftUI

public struct EntryView: View {
    public init() {}
    
    public var body: some View {
        Form {
            Section {
                DatePicker("EntryView.datePicker.title", selection: $date, displayedComponents: .date)
                DatePicker("EntryView.timePicker.title", selection: $date, displayedComponents: .hourAndMinute)
                HStack {
                    Text("EntryView.glucoseField.title")
                    TextField(text: $glucose) {
                        EmptyView()
                    }.multilineTextAlignment(.trailing)
                    Text(verbatim: "mg/dL")
                }
            }

            Section("EntryView.mealField.title") {
                Picker(selection: $mealTime) {
                    Text("EntryView.mealField.unspecified").tag(MealTime.unspecified)
                    Text("EntryView.mealField.before").tag(MealTime.beforeMeal)
                    Text("EntryView.mealField.after").tag(MealTime.afterMeal)
                } label: { EmptyView() }.pickerStyle(.inline)
            }
            Section("EntryView.notesSection.title") {
                TextEditor(text: $notes)
            }
        }
    }

    @State private var date = Date()
    @State private var glucose = ""
    @State private var notes = ""
    @State private var mealTime = MealTime.unspecified

    enum MealTime: Hashable {
        case beforeMeal
        case afterMeal
        case unspecified
    }
}

#Preview {
    EntryView()
}
