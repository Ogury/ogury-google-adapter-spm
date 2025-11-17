//
//  ViewController.swift
//  SpmTestApp
//
//  Created by Jerome TONNELIER on 23/06/2025.
//

import UIKit
import OguryMediationGoogleMobileAds
import OgurySdk
import AppTrackingTransparency
import CryptoKit
import AdSupport

class ViewController: UIViewController {
    @IBOutlet weak var sdkVersion: UILabel!
    @IBOutlet weak var errorLabel: UILabel!  {
        didSet {
            errorLabel.isHidden = true
            errorLabel.numberOfLines = 0
        }
    }

    @IBOutlet weak var sdkStateButton: UIButton!
    @IBOutlet weak var sdkStateLabel: UILabel!  {
        didSet {
            sdkStateLabel.text = "SDK not started"
        }
    }

    @IBOutlet weak var interLabel: UILabel!  {
        didSet {
            interLabel.text = "Interstitial ad"
        }
    }

    @IBOutlet weak var interLoadButton: UIButton!
    @IBOutlet weak var interShowButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!  {
        didSet {
            loader.isHidden = true
            loader.hidesWhenStopped = true
        }
    }
    
    enum SdkState: Equatable {
        case idle, starting, started, error(_: Error)
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
                case (.idle, .idle): return true
                case (.starting, .starting): return true
                case (.started, .started): return true
                case (.error, .error): return true
                default: return false
            }
        }
    }
    var sdkState: SdkState = .idle  {
        didSet {
            DispatchQueue.main.async {
                self.loader.isHidden = self.sdkState != .starting
                self.errorLabel.isHidden = [.idle, .starting, .started].contains(self.sdkState)
                
                switch self.sdkState {
                    case .idle:
                        self.sdkStateLabel.text = "SdK not started"
                        
                    case .starting:
                        self.sdkStateLabel.text = "SDK starting"
                        self.loader.startAnimating()
                        
                    case .started:
                        self.sdkStateLabel.text = "SDK started"
                        
                    case let .error(error):
                        self.errorLabel.text = error.localizedDescription
                        self.sdkStateLabel.text = "SDK error"
                }
            }
        }
    }
    
    enum AdState: Equatable {
        case idle, loading, loaded, showing, closed, error
    }
    var adState: AdState = .idle {
        didSet {
            switch adState {
                case .idle:
                    interLabel.text = "Interstitial ad"
                    
                case .loading:
                    interLabel.text = "⏱️ Interstitial ad"
                    errorLabel.text = ""
                    loader.startAnimating()
                    
                case .loaded:
                    interLabel.text = "✅ Interstitial ad"
                    loader.stopAnimating()
                    
                case .showing:
                    interLabel.text = "🖥️ Interstitial ad"
                    
                case .closed:
                    interLabel.text = "Interstitial ad"
                    
                case .error:
                    interLabel.text = "‼️ Interstitial ad"
            }
        }
    }
    
    enum SdkError: LocalizedError {
        case sdkNotStarted, adMobSdkNotStarted, adapterNotLoaded
        var errorDescription: String? {
            switch self {
                case .sdkNotStarted: return "OgurySdk did not start"
                case .adMobSdkNotStarted: return "AdMob Sdk did not start"
                case .adapterNotLoaded: return "Ogury Adapter was not loaded"
            }
        }
    }
    var interAd: InterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sdkVersion.text = "Ogury Sdk \(Ogury.sdkVersion())"
    }
    
    @IBAction func startSdk(_ sender: Any) {
        Task {
            sdkState = .starting
            adState = .idle
            OguryMediationGoogleMobileAds.shared().setLogLevel(.all)
            // start Ogury
            let (success, error) = await Ogury.start(with: Constants.assetKey)
            if let error {
                self.sdkState = .error(error)
                return
            }
            guard success else {
                self.sdkState = .error(SdkError.sdkNotStarted)
                return
            }
            
            // starting AdMob
            MobileAds.shared.requestConfiguration.testDeviceIdentifiers = ["9f89c84a559f573636a47ff8daed0d33"]
            let res = await MobileAds.shared.start()
            guard !res.adapterStatusesByClassName.isEmpty else {
                self.sdkState = .error(SdkError.adMobSdkNotStarted)
                return
            }
            guard let adMobStatus: AdapterStatus = res.adapterStatusesByClassName["GADMobileAds"],
                  adMobStatus.state == .ready else {
                self.sdkState = .error(SdkError.adMobSdkNotStarted)
                return
            }
            guard let interCEStatus: AdapterStatus = res.adapterStatusesByClassName["OguryInterstitialCustomEvents"],
                  interCEStatus.state == .ready else  {
                self.sdkState = .error(SdkError.adapterNotLoaded)
                return
            }
            self.sdkState = .started
        }
    }
    
    @IBAction func load(_ sender: Any) {
        Task {
            adState = .loading
            self.interAd = try? await InterstitialAd.load(with: Constants.interAdUnitId, request: .init())
            guard let interAd else {
                adState = .error
                return
            }
            adState = .loaded
            interAd.fullScreenContentDelegate = self
            
        }
    }
    
    @IBAction func show(_ sender: Any) {
        interAd?.present(from: self)
        adState = .showing
    }
    
    @IBAction func requestConsent(_ sender: Any) {
        AdMobConsentManager.shared.resetConsent(viewController: self)
    }
}

extension ViewController: FullScreenContentDelegate {
    func adWillPresentFullScreenContent(_ ad: any FullScreenPresentingAd) {
        adState = .showing
    }
    func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        adState = .error
        sdkState = .error(error)
    }
    func adDidDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        adState = .closed
    }
}
