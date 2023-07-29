import SwiftUI

struct NumberButtonStyle: ButtonStyle {
    private let value: NumberValue
    init(value: NumberValue) {
        self.value = value
    }

    private var scaleAnchor: UnitPoint {
        switch value {
        case .number(let string) where string == "0":
            return .bottom
        case .number(let string) where string == "1":
            return .topLeading
        case .number(let string) where string == "2":
            return .top
        case .number(let string) where string == "3":
            return .topTrailing
        case .number(let string) where string == "4":
            return .leading
        case .number(let string) where string == "5":
            return .center
        case .number(let string) where string == "6":
            return .trailing
        case .number(let string) where string == "7":
            return .leading
        case .number(let string) where string == "8":
            return .center
        case .number(let string) where string == "9":
            return .trailing
        case .number:
            return .center
        case .delete:
            return .bottomLeading
        case .done:
            return .bottomTrailing
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.system(size: 22, weight: .semibold, design: .rounded))
            .background(backgroundStyle(for: configuration), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .scaleEffect(configuration.isPressed ? 1.375 : 1.0, anchor: scaleAnchor)
            .zIndex(configuration.isPressed ? 1.0 : 0.0)
            .animation(configuration.isPressed ? nil : .default, value: configuration.isPressed)
    }

    private func backgroundStyle(for configuration: Configuration) -> AnyShapeStyle {
        switch value {
        case .number, .delete:
            guard configuration.isPressed == false else { return AnyShapeStyle(Color.gray) }
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
