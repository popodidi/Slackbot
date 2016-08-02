import PackageDescription

let package = Package(
    name: "Slackbot",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0, minor: 14),
        .Package(url: "https://github.com/qutheory/vapor-tls.git", majorVersion: 0, minor: 3)
    ]
)
