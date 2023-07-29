import SwiftUI

struct PrimaryContainerBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(watchOS 10, *) {
            content
                .containerBackground(Color("Primary", bundle: .main), for: .navigation)
        } else {
            content
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

extension View {
    func primaryContainerBackground() -> ModifiedContent<Self, PrimaryContainerBackgroundViewModifier> {
        self.modifier(PrimaryContainerBackgroundViewModifier())
    }
}
