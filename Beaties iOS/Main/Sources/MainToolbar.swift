import SwiftUI

struct MainToolbar: ToolbarContent {
    @Binding private var isDisplayingEntry: Bool
    init(isDisplayingEntry: Binding<Bool>) {
        _isDisplayingEntry = isDisplayingEntry
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            AddEntryButton(isDisplayingEntry: $isDisplayingEntry)
        }
        ToolbarItem(placement: .primaryAction) {
            MoreButton()
        }
    }
}
