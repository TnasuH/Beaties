import HealthConnect
import SwiftUI

public struct ListContent: View {
    private let entries: [ListEntry]
    public init(samples: [GlucoseSample], isSingleDay: Bool = true) {
        if samples.count > 0 {
            var remainingSamples = samples.sorted { lhs, rhs in
                lhs.date > rhs.date
            }
            let sample = remainingSamples.removeFirst()
            let firstEntry = ListEntry(sample, isFirstEntry: true, isSingleDay: isSingleDay)
            let remainingEntries = remainingSamples.map {
                ListEntry($0, isFirstEntry: false, isSingleDay: isSingleDay)
            }
            entries = [firstEntry] + remainingEntries
        } else {
            entries = []
        }
    }

    public var body: some View {
        ForEach(entries) { ListRow($0) }
    }
}

#Preview {
    List {
        ListContent(samples: [
            GlucoseSample(id: UUID(), value: 120, date: Date()),
            GlucoseSample(id: UUID(), value: 80, date: Date()),
        ], isSingleDay: false)
    }
}
