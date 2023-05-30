import HealthConnect
import SwiftUI

public struct PrimaryView: View {
    @Environment(\.healthRepository) private var repository
    @State private var isEntryShowing = false

    public var body: some View {
        VStack {
            Text("Chart goes here")
            Spacer()
            Button("Add Entry") {
                isEntryShowing = true
            }
        }.sheet(isPresented: $isEntryShowing) {
            EntryView { value in
                do {
                    guard let doubleValue = Double(value)
                    else {
                        throw ValueConversionError.cannotConvertValue(value)
                    }
                    try await repository.addGlucoseValue(doubleValue)
                } catch {
                    dump(error)
                }
            }
        }
    }
}

enum ValueConversionError: Error {
    case cannotConvertValue(String)
}

enum PrimaryViewPreviews: PreviewProvider {
    static var previews: some View {
        PrimaryView()
    }
}
