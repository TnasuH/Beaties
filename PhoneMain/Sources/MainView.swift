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
                EntryView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { MainToolbar(isDisplayingEntry: $isDisplayingEntry) }
        }.task {
            do {
                samples = try await repository.samplesFromToday()
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
