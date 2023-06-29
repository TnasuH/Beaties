import SwiftUI

struct EntryView: View {
    @State private var entry = "0"
    @Environment(\.dismiss) private var dismiss
    private let entryAction: (String) async -> Void

    private let values = [
        "1", "2", "3",
        "4", "5", "6",
        "7", "8", "9",
        NumberValue.delete, "0", .done
    ]

    init(entryAction: @escaping (String) async -> Void) {
        self.entryAction = entryAction
    }

    var body: some View {
        EntryLayout {
            Text(entry)
                .font(.system(size: 23, weight: .semibold, design: .rounded)).padding(.vertical, 4)
            ForEach(values) { value in
                NumberButton(value, action: handleButton(_:))
            }
        }
        .ignoresSafeArea()
        .toolbar(.hidden)
    }

    private func handleButton(_ value: NumberValue) {
        switch value {
        case .number(let string):
            if entry == "0" {
                entry = string
            } else {
                entry.append(string)
            }
        case .delete:
            entry.removeLast()
            if entry.isEmpty {
                entry = "0"
            }
        case .done:
            Task {
                await entryAction(entry)
                dismiss()
            }
        }
    }
}

enum EntryViewPreviews: PreviewProvider {
    static var previews: some View {
        Rectangle().sheet(isPresented: .constant(true), content: { EntryView(entryAction: {_ in }) }).previewLayout(.sizeThatFits)
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
