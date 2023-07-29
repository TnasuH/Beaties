import PhoneHealthConnect
import SwiftUI

public struct OnboardingView: View {
    public var body: some View {
        Button("Set Up") {
            Task {
                try await repository.requestAccess()
                completion()
            }
        }
    }

    public init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    @Environment(\.healthRepository) private var repository
    private let completion: () -> Void
}
