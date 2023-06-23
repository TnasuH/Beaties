import Foundation
import HealthKit

public protocol HealthRepository {
    func addGlucoseValue(_ value: Double) async throws
    func samplesFromToday() async throws -> [GlucoseSample]
    func samplesFromTwoWeeks() async throws -> [GlucoseSample]
}

public actor HealthKitRepository: HealthRepository {
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

    public func samplesFromToday() async throws -> [GlucoseSample] {
        return try await quantitySamplesFromToday().map(GlucoseSample.init)
    }

    private func quantitySamplesFromToday() async throws -> [HKQuantitySample] {
        let now = Date()
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)
        else { return [] }

        let todayStart = Calendar.current.startOfDay(for: now)
        let tomorrowStart = Calendar.current.startOfDay(for: tomorrow)

        let predicate = HKQuery.predicateForSamples(withStart: todayStart, end: tomorrowStart)
        return try await withCheckedThrowingContinuation { continuation in
            var samples = [HKQuantitySample]()
            let query = HKQuantitySeriesSampleQuery(quantityType: Values.glucoseType, predicate: predicate) { _, _, _, sample, isDone, error in
                if let error { return continuation.resume(throwing: error) }
                if let sample { samples.append(sample) }
                if isDone { continuation.resume(returning: samples) }
            }
            query.includeSample = true
            store.execute(query)
        }
    }

    public func samplesFromTwoWeeks() async throws -> [GlucoseSample] {
        return try await quantitySamplesFromTwoWeeks().map(GlucoseSample.init)
    }

    private func quantitySamplesFromTwoWeeks() async throws -> [HKQuantitySample] {
        let now = Date()
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now),
              let twoWeeks = Calendar.current.date(byAdding: .day, value: -30, to: tomorrow)
        else { return [] }

//        let todayStart = Calendar.current.startOfDay(for: now)
        let tomorrowStart = Calendar.current.startOfDay(for: tomorrow)
        let twoWeeksStart = Calendar.current.startOfDay(for: twoWeeks)

        let predicate = HKQuery.predicateForSamples(withStart: twoWeeksStart, end: tomorrowStart)
        return try await withCheckedThrowingContinuation { continuation in
            var samples = [HKQuantitySample]()
            let query = HKQuantitySeriesSampleQuery(quantityType: Values.glucoseType, predicate: predicate) { _, _, _, sample, isDone, error in
                if let error { return continuation.resume(throwing: error) }
                if let sample { samples.append(sample) }
                if isDone { continuation.resume(returning: samples) }
            }
            query.includeSample = true
            store.execute(query)
        }
    }
}
