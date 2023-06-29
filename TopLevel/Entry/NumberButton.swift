import SwiftUI
import WatchKit

struct NumberButton: View {
    private let value: NumberValue
    private let action: (NumberValue) -> Void

    @GestureState private var gestureState = false

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
        .simultaneousGesture(LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity).updating($gestureState) { value, state, _ in
            state = value
            if value {
                WKInterfaceDevice.current().play(.click)
            }
        })
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
