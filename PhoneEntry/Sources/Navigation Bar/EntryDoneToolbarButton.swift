import SwiftUI

struct EntryDoneToolbarButton: View {
    init(glucose: Binding<String>) {
        _glucose = glucose
    }

    var body: some View {
        Button("Done") {
            dismiss()
        }
        .disabled(Int(glucose) == nil)
        .fontWeight(.semibold)
    }

    @Environment(\.dismiss) private var dismiss
    @Binding private var glucose: String
}

#Preview {
    VStack {
        EntryDoneToolbarButton(glucose: .constant(""))
        EntryDoneToolbarButton(glucose: .constant("120"))
    }
}
