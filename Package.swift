import PackageDescription

let package = Package(
    name: "VaporStringEnum",
    targets: [
        Target(name: "VaporStringEnum")
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/fluent-provider.git", majorVersion: 1),
    ]
)
