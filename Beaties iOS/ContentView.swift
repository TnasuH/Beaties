import HealthConnect
import SwiftUI

struct ContentView: View {
    private let repository = HealthKitRepository()

    var body: some View {
        Button {
            Task {
                try await PrintService.print(repository: repository)
            }
        } label: {
            Text("Print")
        }
    }
}

enum ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
