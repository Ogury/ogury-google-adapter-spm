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
        .package(url: "https://github.com/Ogury/ogury-sdk-spm", from: "5.2.3"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "12.13.0"),
    ],
    targets: [
        .binaryTarget(
            name: "OguryMediationGoogleMobileAds",
            url: "https://binaries.ogury.co/release/mediation-google-mobiles-ads-ios/5.2.300/OguryMediationGoogleMobileAds-5.2.300.zip",
            checksum: "0bf13798160a0adc8c4770369436122ff4f043b76443337908bfca6f5e451151"
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
