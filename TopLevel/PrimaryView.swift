import DailyChart
import HealthConnect
import SwiftUI

public struct PrimaryView: View {
    @Environment(\.healthRepository) private var repository
    @State private var isEntryShowing = false
    @State private var chartEntries = [ChartEntry]()

    public var body: some View {
        ChartView(entries: chartEntries)
            .primaryContainerBackground()
            .sheet(isPresented: $isEntryShowing) {
                EntryView { value in
                    do {
                        guard let doubleValue = Double(value)
                        else {
                            throw ValueConversionError.cannotConvertValue(value)
                        }
                        try await repository.addGlucoseValue(doubleValue)
                    } catch {
                        dump(error)
                    }
                }
            }.toolbar {
                if #available(watchOS 10, *) {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isEntryShowing = true
                        } label: {
                            Image(systemName: "plus").foregroundStyle(.white)
                        }
                    }
                }
            }.task {
                do {
                    chartEntries = try await repository.samplesFromToday().map(ChartEntry.init(sample:))
                } catch {
                    dump(error)
                }
            }
    }
}

enum ValueConversionError: Error {
    case cannotConvertValue(String)
}

enum PrimaryViewPreviews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrimaryView()
        }
    }
}
