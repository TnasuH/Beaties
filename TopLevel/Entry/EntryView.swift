import SwiftUI

struct EntryView: View {
    @State private var entry = "0"
    @Environment(\.dismiss) private var dismiss
    private let entryAction: (String) async -> Void

    init(entryAction: @escaping (String) async -> Void) {
        self.entryAction = entryAction
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 3) {
            Text(entry).font(.title3)
            VStack {
                HStack {
                    NumberButton("1", action: handleButton(_:))
                    NumberButton("2", action: handleButton(_:))
                    NumberButton("3", action: handleButton(_:))
                }
                HStack {
                    NumberButton("4", action: handleButton(_:))
                    NumberButton("5", action: handleButton(_:))
                    NumberButton("6", action: handleButton(_:))
                }
                HStack {
                    NumberButton("7", action: handleButton(_:))
                    NumberButton("8", action: handleButton(_:))
                    NumberButton("9", action: handleButton(_:))
                }
                HStack {
                    NumberButton(.delete, action: handleButton(_:))
                    NumberButton("0", action: handleButton(_:))
                    NumberButton(.done, action: handleButton(_:))
                }
            }
        }
        .padding(.bottom, -16)
        .scenePadding()
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
        Rectangle().sheet(isPresented: .constant(true), content: { EntryView(entryAction: {_ in }) })
    }
}
