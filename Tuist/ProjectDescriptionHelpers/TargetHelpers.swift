import ProjectDescription

public func target(baseName: String, platform: Platform, dependencies: [TargetDependency], isShared: Bool, includesResources: Bool) -> Target {
    let directory = isShared ? "Shared" : platform.directory
    let resources: ResourceFileElements? = includesResources ? ["\(directory)/\(baseName)/Resources/**"] : nil
    return Target(
        name: "\(platform.prefix)\(baseName)",
        platform: platform,
        product: .framework,
        bundleId: "com.cocoatype.com.Beaties.\(platform.prefix)\(baseName)",
        sources: ["\(directory)/\(baseName)/Sources/**"],
        resources: resources,
        dependencies: dependencies
    )
}

public func testTarget(baseName: String, platform: Platform, isShared: Bool) -> Target {
    let directory = isShared ? "Shared" : platform.directory
    return Target(
        name: "\(platform.prefix)\(baseName)Tests",
        platform: platform,
        product: .unitTests,
        bundleId: "com.cocoatype.com.Beaties.\(platform.prefix)\(baseName)Tests",
        sources: ["\(directory)/\(baseName)/Tests/**"],
        dependencies: [
            .target(name: "\(platform.prefix)\(baseName)")
        ]
    )
}

public func phoneTarget(baseName: String, dependencies: [TargetDependency] = [], isShared: Bool = false, includesResources: Bool = false) -> Target {
    target(baseName: baseName, platform: .iOS, dependencies: dependencies, isShared: isShared, includesResources: includesResources)
}

public func phoneTestTarget(baseName: String, isShared: Bool = false) -> Target {
    testTarget(baseName: baseName, platform: .iOS, isShared: isShared)
}

public func watchTarget(baseName: String, dependencies: [TargetDependency] = [], isShared: Bool = false, includesResources: Bool = false) -> Target {
    target(baseName: baseName, platform: .watchOS, dependencies: dependencies, isShared: isShared, includesResources: includesResources)
}

public func watchTestTarget(baseName: String, isShared: Bool = false) -> Target {
    testTarget(baseName: baseName, platform: .watchOS, isShared: isShared)
}

extension Platform {
    var prefix: String {
        switch self {
        case .iOS: "Phone"
        case .macOS: "Mac"
        case .watchOS: "Watch"
        case .tvOS: "TV"
        case .visionOS: "Vision"
        @unknown default: ""
        }
    }

    var directory: String {
        switch self {
        case .iOS: "Beaties iOS"
        case .macOS: "Beaties macOS"
        case .watchOS: "Beaties watchOS"
        case .tvOS: "Beaties tvOS"
        case .visionOS: "Beaties visionOS"
        @unknown default: ""
        }
    }
}
