import ProjectDescription

let project = Project(
    name: "FlashStudy",
    options: .options(
        automaticSchemesOptions: .enabled()
    ),
    targets: [
        .target(
            name: "FlashStudy",
            destinations: .iOS,
            product: .app,
            bundleId: "com.example.flashstudy",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": .dictionary([:])
            ]),
            sources: ["FlashStudy/**/*.swift"],
            resources: ["FlashStudy/Resources/**"]
        )
    ]
)
