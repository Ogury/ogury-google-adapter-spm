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
        .package(url: "https://github.com/Ogury/ogury-sdk-spm", from: "5.2.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "12.13.0"),
    ],
    targets: [
        .binaryTarget(
            name: "OguryMediationGoogleMobileAds",
            url: "https://binaries.ogury.co/release/mediation-google-mobiles-ads-ios/5.2.0.0/OguryMediationGoogleMobileAds-5.2.0.0.zip",
            checksum: "eff1952b29ea349806000c31b6233fa7e9be55de6f656574bf8fdf03add424f8"
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
