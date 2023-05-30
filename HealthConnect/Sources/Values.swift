import HealthKit

enum Values {
    static let glucoseType: HKQuantityType = {
        guard let glucoseType = HKObjectType.quantityType(forIdentifier: .bloodGlucose)
        else { fatalError("Unable to create blood glucose type") }
        return glucoseType
    }()

    static let glucoseUnit: HKUnit = {
        let milligrams = HKUnit.gramUnit(with: .milli)
        let deciliter = HKUnit.literUnit(with: .deci)
        return milligrams.unitDivided(by: deciliter)
    }()

    static var isRunningPreviews: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
    }
}
