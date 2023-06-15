import HealthKit

public struct GlucoseSample {
    public let id: UUID
    public let value: Double
    public let date: Date

    init(sample: HKQuantitySample) {
        id = sample.uuid
        value = sample.quantity.doubleValue(for: Values.glucoseUnit)
        date = sample.startDate
    }
}
