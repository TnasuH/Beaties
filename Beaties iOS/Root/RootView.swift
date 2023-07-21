import HealthConnect
import PhoneMain
import PhoneOnboarding
import SwiftUI

public struct RootView: View {
    public var body: some View {
        Group {
            switch accessStatus {
            case .undetermined:
                OnboardingView(completion: updateAccessStatus)
            case .allowed:
                MainView()
            case .denied:
                DeniedView()
            }
        }.onAppear {
            updateAccessStatus()
        }
    }

    public init() {}

    func updateAccessStatus() {
        accessStatus = repository.accessStatus
    }

    @State private var accessStatus = AuthorizationStatus.undetermined
    @Environment(\.healthRepository) private var repository
}
