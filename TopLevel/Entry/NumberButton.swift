import SwiftUI

struct NumberButton: View {
    private let value: NumberValue
    private let action: (NumberValue) -> Void

    init(_ value: NumberValue, action: @escaping (NumberValue) -> Void) {
        self.value = value
        self.action = action
    }

    var body: some View {
        Button(action: {
            self.action(self.value)
        }, label: {
            self.label
                .frame(maxWidth: .infinity)
                .frame(height: 28)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(backgroundColor))
        })
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var label: some View {
        switch value {
        case .number(let string):
            Text(string)
        case .delete:
            Image(systemName: "delete.backward")
        case .done:
            Image(systemName: "return")
        }
    }

    private var backgroundColor: Color {
        switch value {
        case .number, .delete:
            return .white.opacity(0.3)
        case .done:
            return .accentColor
        }
    }
}
