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
        .package(url: "https://github.com/Ogury/ogury-sdk-spm", from: "5.3.1"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", "12.0.0"..<"15.0.0"),
    ],
    targets: [
        .binaryTarget(
            name: "OguryMediationGoogleMobileAds",
            url: "https://binaries.ogury.co/release/mediation-google-mobiles-ads-ios/5.3.100/OguryMediationGoogleMobileAds-5.3.100.zip",
            checksum: "0c9fd8477836569db885734d3c8ceae2522cddee71ad56ef1baa91f6ac4dce47"
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
