import SwiftUI

struct EntryToolbarContent: ToolbarContent {
    init(glucose: Binding<String>, doneAction: @escaping () async -> Void) {
        _glucose = glucose
        self.doneAction = doneAction
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            EntryCancelToolbarButton()
        }

        ToolbarItem(placement: .primaryAction) {
            EntryDoneToolbarButton(glucose: $glucose, doneAction: doneAction)
        }
    }

    @Binding private var glucose: String
    private let doneAction: () async -> Void
}
