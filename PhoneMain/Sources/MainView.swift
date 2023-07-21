import Assets
import HealthConnect
import PhoneEntry
import PhoneList
import SwiftUI

public struct MainView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                ListContent(samples: samples)
            }
            .sheet(isPresented: $isDisplayingEntry) {
                EntryView()
            }
            .toolbar { MainToolbar(isDisplayingEntry: $isDisplayingEntry) }
        }.task {
            do {
                samples = try await repository.samplesFromTwoWeeks()
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
