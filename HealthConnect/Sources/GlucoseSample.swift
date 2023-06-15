import HealthKit

public struct GlucoseSample {
    public let id: UUID
    public let value: Double
    public let date: Date

    public init(id: UUID, value: Double, date: Date) {
        self.id = id
        self.value = value
        self.date = date
    }

    init(sample: HKQuantitySample) {
        self.init(
            id: sample.uuid,
            value: sample.quantity.doubleValue(for: Values.glucoseUnit),
            date: sample.startDate
        )
    }
}
