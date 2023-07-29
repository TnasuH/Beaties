import SwiftUI

struct EntryForm: View {
    @Binding private var date: Date
    @Binding private var glucose: String
    @Binding private var notes: String
    @Binding private var mealTime: MealTime
    init(date: Binding<Date>, glucose: Binding<String>, notes: Binding<String>, mealTime: Binding<MealTime>) {
        _date = date
        _glucose = glucose
        _notes = notes
        _mealTime = mealTime
    }

    var body: some View {
        Form {
            Section {
                DatePicker("EntryView.datePicker.title", selection: $date, displayedComponents: .date)
                DatePicker("EntryView.timePicker.title", selection: $date, displayedComponents: .hourAndMinute)
                HStack {
                    Text("EntryView.glucoseField.title")
                    TextField(text: $glucose) {
                        EmptyView()
                    }.multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($isGlucoseFocused)
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
        }.task { isGlucoseFocused = true }
    }

    @FocusState private var isGlucoseFocused: Bool
}

#Preview {
    EntryForm(date: .constant(Date()), glucose: .constant(""), notes: .constant(""), mealTime: .constant(.beforeMeal))
}
