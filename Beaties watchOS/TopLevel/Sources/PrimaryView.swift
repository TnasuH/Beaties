import SwiftUI
import WatchDailyChart
import WatchHealthConnect

public struct PrimaryView: View {
    @Environment(\.healthRepository) private var repository
    @State private var isEntryShowing = false
    @State private var samples = [GlucoseSample]()

    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                LatestEntryText(latestSample)
            }
            ChartView(entries: samples.map(ChartEntry.init(sample:)))
            Spacer()
            if #unavailable(watchOS 10) {
                LegacyAddEntryButton(isEntryShowing: $isEntryShowing)
                    .controlSize(.mini)
                    .padding(.vertical, 8)
            }
        }
        .scenePadding(.horizontal)
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
                    AddEntryButton(isEntryShowing: $isEntryShowing)
                }
            }
        }.task {
            do {
                samples = try await repository.samplesFromToday()
            } catch {
                dump(error)
            }
        }
    }

    private var latestSample: GlucoseSample? {
        return samples.max { lhs, rhs in
            lhs.date < rhs.date
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
                .environment(\.healthRepository, PreviewHealthRepository())
        }
    }
}
