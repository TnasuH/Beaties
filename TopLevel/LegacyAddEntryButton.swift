import SwiftUI

struct LegacyAddEntryButton: View {
    @Binding private var isEntryShowing: Bool

    init(isEntryShowing: Binding<Bool>) {
        _isEntryShowing = isEntryShowing
    }

    var body: some View {
        Button("Add Entry") {
            isEntryShowing = true
        }
    }
}

