import SwiftUI

struct MoreButton: View {
    var body: some View {
        Menu {
            PrintButton()
            ShareButton(action: {})
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

#Preview {
    MoreButton()
}
