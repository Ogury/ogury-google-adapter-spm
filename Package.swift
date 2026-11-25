// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "OguryGoogleMobileAdsAdapter",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "OguryGoogleMobileAdsAdapter",
            targets: ["OguryGoogleMobileAdsAdapter"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Ogury/ogury-sdk-spm", from: "5.4.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", "12.0.0"..<"15.0.0"),
    ],
    targets: [
        .binaryTarget(
            name: "OguryMediationGoogleMobileAds",
            url: "https://binaries.ogury.co/release/mediation-google-mobiles-ads-ios/5.4.0/OguryMediationGoogleMobileAds-5.4.0.zip",
            checksum: "49ae0721cbae641cfa274296082e352862eb773dceb69f3100bc20d7b6512c76"
        ),
        .target(
            name: "OguryGoogleMobileAdsAdapter",
            dependencies: [
                "OguryMediationGoogleMobileAds",
                .product(name: "OgurySdk", package: "ogury-sdk-spm"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            linkerSettings: [
                .linkedLibrary("c++")
            ]
        )
    ]
)
