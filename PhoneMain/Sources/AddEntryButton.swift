import SwiftUI

struct AddEntryButton: View {
    @Binding private var isDisplayingEntry: Bool
    init(isDisplayingEntry: Binding<Bool>) {
        _isDisplayingEntry = isDisplayingEntry
    }

    var body: some View {
        Button {
            isDisplayingEntry = true
        } label: {
            Text("\(Image.addEntryButton) Log Glucose")
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
        }
    }
}

#Preview {
    AddEntryButton(isDisplayingEntry: .constant(false))
}
