import SwiftUI

struct EntryCancelToolbarButton: View {
    var body: some View {
        Button("Cancel") {
            dismiss()
        }
    }

    @Environment(\.dismiss) private var dismiss
}

#Preview {
    EntryCancelToolbarButton()
}
