import HealthKit

public enum AuthorizationStatus {
    case undetermined
    case allowed
    case denied

    init(_ healthStatus: HKAuthorizationStatus) {
        switch healthStatus {
        case .notDetermined:
            self = .undetermined
        case .sharingDenied:
            self = .denied
        case .sharingAuthorized:
            self = .allowed
        @unknown default:
            self = .undetermined
        }
    }
}
