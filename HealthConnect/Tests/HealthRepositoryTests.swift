import HealthKit
import XCTest

@testable import HealthConnect

class HealthRepositoryTests: XCTestCase {
    func testHasAccessReturnsFalseWhenDenied() async {
        let mockStore = MockHealthStore(authorization: .sharingDenied)
        let repository = HealthRepository(store: mockStore)
        let hasAccess = await repository.hasAccess

        XCTAssertFalse(hasAccess)
    }

    func testHasAccessReturnsFalseWhenUndetermined() async {
        let mockStore = MockHealthStore(authorization: .notDetermined)
        let repository = HealthRepository(store: mockStore)
        let hasAccess = await repository.hasAccess

        XCTAssertFalse(hasAccess)
    }

    func testHasAccessReturnsTrueWhenAllowed() async {
        let mockStore = MockHealthStore(authorization: .sharingAuthorized)
        let repository = HealthRepository(store: mockStore)
        let hasAccess = await repository.hasAccess

        XCTAssertTrue(hasAccess)
    }
}

private struct MockHealthStore: HealthStore {
    private let authorization: HKAuthorizationStatus
    init(authorization: HKAuthorizationStatus = .sharingAuthorized) {
        self.authorization = authorization
    }

    func authorizationStatus(for: HKObjectType) -> HKAuthorizationStatus {
        return authorization
    }

    func requestAuthorization(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws {}
}
