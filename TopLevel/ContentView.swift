import HealthConnect
import SwiftUI

public struct ContentView: View {
    @State private var hasAccess: Bool = false
    @State private var loadingState: LoadingState
    private let repository = HealthKitRepository()

    public init() {
        self.init(loadingState: .loading)
    }

    fileprivate init(loadingState: LoadingState) {
        _loadingState = .init(initialValue: loadingState)
    }

    public var body: some View {
        NavigationStack {
            switch loadingState {
            case .loading:
                ProgressView()
            case .accessAllowed:
                PrimaryView()
            case .accessDenied:
                Text("Denied")
            case .error(let error):
                Text(String(describing: error))
            }
        }
        .task {
            do {
                let accessStatus = await repository.accessStatus
                switch accessStatus {
                case .undetermined:
                    try await repository.requestAccess()
                case .allowed:
                    loadingState = .accessAllowed
                case .denied:
                    loadingState = .accessDenied
                }
            } catch {
                loadingState = .error(error)
            }
        }
    }

    enum LoadingState {
        case loading
        case accessAllowed
        case accessDenied
        case error(Error)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loadingState: .accessAllowed)
    }
}
