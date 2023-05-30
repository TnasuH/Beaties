import HealthKit

public protocol HealthStore {
    func authorizationStatus(for: HKObjectType) -> HKAuthorizationStatus
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws
    func save(_ object: HKObject) async throws
}

extension HKHealthStore: HealthStore {}
