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

## Versioning Documentation - Ogury AdMob Adapter

### Versioning System

The Ogury AdMob Adapter uses a 3-digit versioning system that encodes both the underlying Ogury SDK version and adapter revisions.

#### Version Format
```
MAJOR.MINOR.ENCODED
```

Where `ENCODED` = `(SDK Patch × 100) + Adapter Revision`

#### Examples

| Adapter Version (internal) | Public Version | Description |
|---------------------------|----------------|-------------|
| 5.2.0.0 | **5.2.0** | Adapter for Ogury SDK 5.2.0 (initial release) |
| 5.2.0.1 | **5.2.1** | Adapter hotfix for SDK 5.2.0 |
| 5.2.0.2 | **5.2.2** | Second adapter hotfix for SDK 5.2.0 |
| 5.2.1.0 | **5.2.100** | Adapter for Ogury SDK 5.2.1 (initial release) |
| 5.2.1.1 | **5.2.101** | Adapter hotfix for SDK 5.2.1 |
| 5.2.2.0 | **5.2.200** | Adapter for Ogury SDK 5.2.2 (initial release) |

#### Why This System?

This encoding system is necessary for:

1. **Technical Compatibility**: Dependency managers (Swift Package Manager, CocoaPods) and the App Store only accept 3-digit versions
2. **Maintenance Flexibility**: Allows publishing adapter fixes independently of Ogury SDK releases
3. **Correct Semantic Ordering**: Ensures versions are always chronologically ordered

#### Decoding a Version

To identify which Ogury SDK version is used by the adapter:
```
Ogury SDK Version = MAJOR.MINOR.(ENCODED ÷ 100)
Adapter Revision = ENCODED mod 100
```

**Examples:**
- `5.2.101` → Ogury SDK **5.2.1**, adapter revision **1**
- `5.2.200` → Ogury SDK **5.2.2**, adapter revision **0**
- `5.2.1` → Ogury SDK **5.2.0**, adapter revision **1**

#### Version Selection

##### CocoaPods
```ruby
# Always use the latest compatible version
pod 'OguryAdapter', '~> 5.2'

# Specific minimum version
pod 'OguryAdapter', '>= 5.2.100'
```

##### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/Ogury/ogury-admob-adapter-ios-spm.git", 
             from: "5.2.0")
]
```

#### CHANGELOG

See [CHANGELOG.md](./CHANGELOG.md) for the mapping between each public version and its associated Ogury SDK version.

#### Technical Notes

- Versions follow the [Semantic Versioning 2.0.0 specification](https://semver.org/)
- Version ordering is guaranteed correct: `5.2.0 < 5.2.1 < 5.2.2 < ... < 5.2.99 < 5.2.100 < 5.2.101`
- This system supports Ogury SDK patch versions from 0 to 99 (more than sufficient in practice)

#### Frequently Asked Questions

**Q: Why does version 5.2.100 come after 5.2.99?**  
A: In Semantic Versioning, version numbers are compared numerically segment by segment. Since 100 > 99, version 5.2.100 is indeed greater than 5.2.99.

**Q: How do I know which Ogury SDK version I'm using?**  
A: Divide the last digit by 100. For example, `5.2.150` = Ogury SDK `5.2.1` (because 150 ÷ 100 = 1).

**Q: Can I use a specific Ogury SDK version?**  
A: Yes, choose the corresponding adapter version. For example, for Ogury SDK 5.2.1, use adapter `5.2.100` or higher (up to `5.2.199`).

---

*This versioning system is inspired by Google AdMob's official mediation adapters to ensure compatibility with the iOS mobile ecosystem.*

## Companion test application
You can check our companion test application `OgurySpmTestApp` that ships with our SDK. 

Please note that in order to be able to launch the project, the swift package (i.e. Package.swift) must not be already opened in Xcode. 

Check out our integration [docs](https://support.ogury.com/inapp/ogury-mediate/google-admob) for more info on getting started with the Ogury Sdk.