import SwiftUI

struct AddEntryButton: View {
    @Binding private var isEntryShowing: Bool

    init(isEntryShowing: Binding<Bool>) {
        _isEntryShowing = isEntryShowing
    }

    var body: some View {
        Button {
            isEntryShowing = true
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .fontWeight(.black)
        }
    }
}
