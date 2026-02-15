// swift-tools-version: 5.9
// Hospital Adventure - Swift Student Challenge
// A gentle app to help children prepare for hospital visits

import PackageDescription

let packagekrr = Package(
    name: "HospitalAdventure",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "HospitalAdventure",
            targets: ["HospitalAdventure"]
        )
    ],
    targets: [
        .executableTarget(
            name: "HospitalAdventure",
            path: "Sources/HospitalAdventure"
        )
    ]
)
