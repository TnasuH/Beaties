import Foundation

public struct PreviewHealthRepository: HealthRepository {
    public init() {}
    public var accessStatus: AuthorizationStatus { .allowed }
    public func requestAccess() async throws {}

    public func addGlucoseValue(_ value: Double) async throws {}

    public func samplesFromToday() -> [GlucoseSample] {
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd = Calendar.current.date(byAdding: .day, value: 1, to: todayStart)!
        return Self.randomSamples(count: 6, dateRange: todayStart..<todayEnd)
    }

    public func samplesFromTwoWeeks() -> [GlucoseSample] {
        Self.randomSamples(count: 100, dateRange: Date(timeIntervalSinceNow: -86400 * 14)..<Date())
    }

    private static func randomSamples(count: Int, dateRange: Range<Date>) -> [GlucoseSample] {
        let randomValuesRange = 70...120
        return (0..<count).map { _ in
            let randomValue = randomValuesRange.randomElement() ?? 100
            return GlucoseSample(id: UUID(), value: Double(randomValue), date: Date.random(in: dateRange))
        }
    }
}

extension Date {
    static func random(in range: Range<Date>) -> Date {
        let intervalRange = range.lowerBound.timeIntervalSinceReferenceDate..<range.upperBound.timeIntervalSinceReferenceDate
        let randomInterval = Double.random(in: intervalRange)
        return Date(timeIntervalSinceReferenceDate: randomInterval)
    }
}
