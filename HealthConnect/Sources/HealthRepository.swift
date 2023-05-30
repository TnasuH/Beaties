import Foundation
import HealthKit

public actor HealthRepository {
    private let store: HealthStore
    public init() {
        self.init(store: HKHealthStore())
    }

    init(store: HealthStore) {
        self.store = store
    }

    public var accessStatus: AuthorizationStatus {
        let healthStatus = store.authorizationStatus(for: Values.glucoseType)
        return AuthorizationStatus(healthStatus)
    }

    public func requestAccess() async throws {
        guard Values.isRunningPreviews == false else { return }
        try await store.requestAuthorization(toShare: [Values.glucoseType], read: [Values.glucoseType])
    }

    public func addGlucoseValue(_ value: Double) async throws {
        let quantity = HKQuantity(unit: Values.glucoseUnit, doubleValue: value)
        let sample = HKQuantitySample(type: Values.glucoseType, quantity: quantity, start: Date(), end: Date())
        try await store.save(sample)
    }
}
