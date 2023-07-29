import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Beaties",
    organizationName: "Cocoatype",
    settings: .settings(
        base: [
            "DEVELOPMENT_TEAM": "287EDDET2B",
            "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
            "WATCHOS_DEPLOYMENT_TARGET": "9.0",
        ]
    ),
    targets: [
        Target(
            name: "Beaties iOS",
            platform: .iOS,
            product: .app,
            productName: "Beaties",
            bundleId: "com.cocoatype.Beaties",
            infoPlist: .extendingDefault(with: [
                "NSHealthShareUsageDescription": "Beaties needs to read your blood glucose data.",
                "NSHealthUpdateUsageDescription": "Beaties needs to be able to update your blood glucose data.",
                "UILaunchScreen": [:],
            ]),
            sources: ["Beaties iOS/App/Sources/**"],
            resources: ["Beaties iOS/App/Resources/**"],
            entitlements: "Beaties iOS/App/Beaties iOS.entitlements",
            dependencies: [
                .target(name: "PhoneRoot"),
                .target(name: "Beaties watchOS"),
            ],
            settings: .settings(
                base: [
                    "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor"
                ]
            )
        ),
        Target(
            name: "Beaties watchOS",
            platform: .watchOS,
            product: .app,
            productName: "Beaties",
            bundleId: "com.cocoatype.Beaties.watch",
            infoPlist: .extendingDefault(with: [
                "NSHealthShareUsageDescription": "Beaties needs to read your blood glucose data.",
                "NSHealthUpdateUsageDescription": "Beaties needs to be able to update your blood glucose data.",
                "WKApplication": true,
                "WKCompanionAppBundleIdentifier": "com.cocoatype.Beaties",
            ]),
            sources: ["Beaties watchOS/App/Sources/**"],
            resources: ["Beaties watchOS/App/Resources/**"],
            entitlements: "Beaties watchOS/App/Beaties Watch App.entitlements",
            dependencies: [
                .target(name: "WatchTopLevel"),
            ],
            settings: .settings(
                base: [
                    "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor"
                ]
            )
        ),
        Target(
            name: "Complication",
            platform: .watchOS,
            product: .appExtension,
            bundleId: "com.cocoatype.Beaties.watchkitextension.complication",
            sources: ["Beaties watchOS/Complication/Sources/**"],
            resources: ["Beaties watchOS/Complication/Resources/**"]
        ),
        // iOS Frameworks
        phoneTarget(baseName: "Assets", isShared: true, includesResources: true),
        phoneTarget(
            baseName: "Chart",
            dependencies: [
                .target(name: "PhoneHealthConnect"),
            ]
        ),
        phoneTarget(
            baseName: "Entry",
            dependencies: [
                .target(name: "PhoneHealthConnect"),
            ],
            includesResources: true
        ),
        phoneTarget(baseName: "HealthConnect", isShared: true),
        phoneTestTarget(baseName: "HealthConnect", isShared: true),
        phoneTarget(
            baseName: "List",
            dependencies: [
                .target(name: "PhoneHealthConnect"),
            ]
        ),
        phoneTarget(
            baseName: "Main",
            dependencies: [
                .target(name: "PhoneAssets"),
                .target(name: "PhoneHealthConnect"),
                .target(name: "PhoneChart"),
                .target(name: "PhoneEntry"),
                .target(name: "PhoneList"),
                .target(name: "PhonePrinting"),
            ]
        ),
        phoneTestTarget(baseName: "Main"),
        phoneTarget(
            baseName: "Onboarding",
            dependencies: [
                .target(name: "PhoneHealthConnect"),
            ]
        ),
        phoneTarget(
            baseName: "Printing",
            dependencies: [
                .target(name: "PhoneHealthConnect"),
            ]
        ),
        phoneTarget(
            baseName: "Root",
            dependencies: [
                .target(name: "PhoneHealthConnect"),
                .target(name: "PhoneMain"),
                .target(name: "PhoneOnboarding"),
            ]
        ),

        // watchOS Frameworks
        watchTarget(
            baseName: "Assets",
            isShared: true,
            includesResources: true
        ),
        watchTarget(baseName: "Complication", includesResources: true), // not actually a framework
        watchTarget(
            baseName: "DailyChart",
            dependencies: [
                .target(name: "WatchHealthConnect"),
            ]
        ),
        watchTarget(
            baseName: "HealthConnect",
            isShared: true
        ),
        watchTestTarget(
            baseName: "HealthConnect",
            isShared: true
        ),
        watchTarget(
            baseName: "TopLevel",
            dependencies: [
                .target(name: "WatchDailyChart"),
            ]
        ),
    ])
