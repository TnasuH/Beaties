import HealthConnect
import SwiftUI

struct HealthRepositoryKey: EnvironmentKey {
    static let defaultValue = HealthRepository()
}

extension EnvironmentValues {
    var healthRepository: HealthRepository {
        get { self[HealthRepositoryKey.self] }
        set { self[HealthRepositoryKey.self] = newValue }
    }
}
