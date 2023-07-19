import Assets
import HealthConnect
import PhoneEntry
import SwiftUI

public struct MainView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            ScrollView {
            }
            .sheet(isPresented: $isDisplayingEntry) {
                EntryView()
            }
            .toolbar { MainToolbar(isDisplayingEntry: $isDisplayingEntry) }
        }
    }

    @State private var isDisplayingEntry = false
}

enum ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        MainView()
            .tint(Color.appOrange)
    }
}
