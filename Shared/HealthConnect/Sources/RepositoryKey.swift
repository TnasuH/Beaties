import SwiftUI

struct HealthRepositoryKey: EnvironmentKey {
    static let defaultValue: HealthRepository = HealthKitRepository()
}

extension EnvironmentValues {
    public var healthRepository: HealthRepository {
        get { self[HealthRepositoryKey.self] }
        set { self[HealthRepositoryKey.self] = newValue }
    }
}
