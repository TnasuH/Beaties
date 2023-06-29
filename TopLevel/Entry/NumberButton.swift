import SwiftUI

struct NumberButton: View {
    private let value: NumberValue
    private let action: (NumberValue) -> Void

    init(_ value: NumberValue, action: @escaping (NumberValue) -> Void) {
        self.value = value
        self.action = action
    }

    var body: some View {
        Button {
            action(self.value)
        } label: {
            switch value {
            case .number(let string):
                Text(string)
            case .delete:
                Image(systemName: "delete.backward")
            case .done:
                Image(systemName: "return")
            }
        }
        .buttonStyle(NumberButtonStyle(value: value))
    }
}

struct NumberButtonStyle: ButtonStyle {
    private let value: NumberValue
    init(value: NumberValue) {
        self.value = value
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.system(size: 22, weight: .semibold, design: .rounded))
            .background(backgroundStyle, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var backgroundStyle: AnyShapeStyle {
        switch value {
        case .number, .delete:
            if #available(watchOS 10, *) {
                return AnyShapeStyle(.fill.tertiary)
            } else {
                return AnyShapeStyle(Color.white.opacity(0.3))
            }
        case .done:
            return AnyShapeStyle(Color("Primary"))
        }
    }
}

enum NumberButtonPreview: PreviewProvider {
    static var previews: some View {
        HStack {
            NumberButton("4", action: { _ in }).frame(width: 51, height: 39)
            NumberButton(.delete, action: { _ in }).frame(width: 51, height: 39)
            NumberButton(.done, action: { _ in }).frame(width: 51, height: 39)
        }
    }
}
