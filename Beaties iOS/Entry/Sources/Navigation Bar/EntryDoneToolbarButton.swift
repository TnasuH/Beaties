import SwiftUI

struct EntryDoneToolbarButton: View {
    init(glucose: Binding<String>, doneAction: @escaping () async -> Void) {
        _glucose = glucose
        self.doneAction = doneAction
    }

    var body: some View {
        Button("Done") {
            Task {
                await doneAction()
                await MainActor.run {
                    dismiss()
                }
            }
        }
        .disabled(Int(glucose) == nil)
        .fontWeight(.semibold)
    }

    @Environment(\.dismiss) private var dismiss
    @Binding private var glucose: String
    private let doneAction: () async -> Void
}

#Preview {
    VStack {
        EntryDoneToolbarButton(glucose: .constant("")) {}
        EntryDoneToolbarButton(glucose: .constant("120")) {}
    }
}
