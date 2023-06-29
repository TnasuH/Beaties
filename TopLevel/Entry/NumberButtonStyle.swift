import SwiftUI

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
            .scaleEffect(configuration.isPressed ? 1.375 : 1.0)
            .animation(configuration.isPressed ? nil : .default, value: configuration.isPressed)
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
