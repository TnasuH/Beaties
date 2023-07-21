import SwiftUI

struct EntryToolbarContent: ToolbarContent {
    init(glucose: Binding<String>) {
        _glucose = glucose
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            EntryCancelToolbarButton()
        }

        ToolbarItem(placement: .primaryAction) {
            EntryDoneToolbarButton(glucose: $glucose)
        }
    }

    @Binding private var glucose: String
}
