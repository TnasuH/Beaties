import Assets
import HealthConnect
import PhoneChart
import PhoneEntry
import PhoneList
import SwiftUI

public struct MainView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                ChartView(samples: samples)
                    .aspectRatio(16/9, contentMode: .fit)
                    .listRowSeparator(.hidden)
                    .padding(.top, 20)

                Text("Today’s Entries")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .listRowSeparator(.hidden)
                    .padding(.top, 20)
                Section {
                    ListContent(samples: samples, isSingleDay: true)
                }
//                Section {
//                    ListContent(samples: samples)
//                }
            }
            .listStyle(.plain)
            .sheet(isPresented: $isDisplayingEntry) {
                refreshSamples(animated: true)
            } content: {
                EntryView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { MainToolbar(isDisplayingEntry: $isDisplayingEntry) }
        }.onAppear {
            refreshSamples(animated: false)
        }
    }

    private func refreshSamples(animated: Bool) {
        let animation: Animation? = animated ? .default : nil
        Task {
            do {
                let newSamples = try await repository.samplesFromToday()
                await MainActor.run {
                    withAnimation(animation) {
                        samples = newSamples
                    }
                }
            } catch {
                fatalError(String(describing: error))
            }
        }
    }

    @Environment(\.healthRepository) var repository
    @State private var isDisplayingEntry = false
    @State private var samples = [GlucoseSample]()
}

enum ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        MainView()
            .tint(Color.appOrange)
            .environment(\.healthRepository, PreviewHealthRepository())
    }
}
