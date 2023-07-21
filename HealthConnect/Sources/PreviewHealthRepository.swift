import Foundation

public struct PreviewHealthRepository: HealthRepository {
    public init() {}
    public var accessStatus: AuthorizationStatus { .allowed }
    public func requestAccess() async throws {}

    public func addGlucoseValue(_ value: Double) async throws {}

    public func samplesFromToday() async throws -> [GlucoseSample] {
        randomEntries(count: 6)
    }

    public func samplesFromTwoWeeks() async throws -> [GlucoseSample] {
        randomEntries(count: 100)
    }

    private func randomEntries(count: Int) -> [GlucoseSample] {
        let randomValuesRange = 70...120
        return (0..<count).map { _ in
            let randomValue = randomValuesRange.randomElement() ?? 100
            return GlucoseSample(id: UUID(), value: Double(randomValue), date: Date())
        }
    }
}
