# ogury-google-adapter-spm
Welcome to the Swift Package Manager repository for iOS Ogury AdMob Custom Events adapter

## Installation

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Directly from Xcode
This is the recommend method when you integrate Ogury Sdks with SPM right into your app. 

1. Open File > Add Package Dependency right from Xcode's [file menu](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#Add-a-package-dependency)
2. In the search field, enter `https://github.com/Ogury/ogury-google-adapter-spm`
3. We recommend that you always use the latest version
4. Be sure to target your app's target when validating the Sdk dependency

We recommend that you build your app once before importing our Sdk as it will allow Xcode to properly resolve dependencies

### From another package
To integrate the OgurySdk into your Xcode project using Swift Package Manager:

1. Add it to the `dependencies` of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Ogury/ogury-google-adapter-spm")
]
```

## Required: Linker Flag

Add `-ObjC` to your app target's **Build Settings → Other Linker Flags**.

## Companion test application
You can check our companion test application `OgurySpmTestApp` that ships with our SDK. 

Please note that in order to be able to launch the project, the swift package (i.e. Package.swift) must not be already opened in Xcode. 

Check out our integration [docs](https://support.ogury.com/inapp/ogury-mediate/google-admob) for more info on getting started with the Ogury Sdk.