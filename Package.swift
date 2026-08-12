// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "OguryGoogleMobileAdsAdapter",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "OguryGoogleMobileAdsAdapter",
            targets: ["OguryGoogleMobileAdsAdapter"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Ogury/ogury-sdk-spm", from: "5.3.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "12.13.0"),
    ],
    targets: [
        .binaryTarget(
            name: "OguryMediationGoogleMobileAds",
            url: "https://binaries.ogury.co/release/mediation-google-mobiles-ads-ios/5.3.0/OguryMediationGoogleMobileAds-5.3.0.zip",
            checksum: "e7f3972b82c4928cc3a0a5a1d5030d78be6476a9ec820a5c325e7a9ba8d85da8"
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
