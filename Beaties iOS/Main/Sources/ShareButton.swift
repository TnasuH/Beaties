import SwiftUI

struct ShareButton: View {
    private let action: () -> Void
    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Label(
                title: { Text("ShareButton.title") },
                icon: { Image(systemName: "square.and.arrow.up") }
            )
        }
    }
}

#Preview {
    ShareButton {}
}
