import SwiftUI

struct PrimaryContainerBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(watchOS 10, *) {
            content.containerBackground(.orange, for: .navigation)
        } else {
            content
        }
    }
}

extension View {
    func primaryContainerBackground() -> ModifiedContent<Self, PrimaryContainerBackgroundViewModifier> {
        self.modifier(PrimaryContainerBackgroundViewModifier())
    }
}
