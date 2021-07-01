//
//  Admob.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/7/1.
//

import Foundation
import Firebase
import GoogleMobileAds
import UIKit
extension UIViewController {
    static func getLastPresentedViewController() -> UIViewController? {
        let window = UIApplication.shared.windows.first {
            $0.isKeyWindow
        }
        var presentedViewController = window?.rootViewController
        while presentedViewController?.presentedViewController != nil {
            presentedViewController = presentedViewController?.presentedViewController
        }
        return presentedViewController
    }
}
class RewardedAdController: NSObject, GADFullScreenContentDelegate {
    private var ad: GADRewardedAd?
    
    func loadAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: request) {ad, error in
            if let error = error {
                print(error)
                return
            }
            ad?.fullScreenContentDelegate = self
            self.ad = ad
        }
    }
    func showAd() {
        if let ad = ad,
           let controller = UIViewController.getLastPresentedViewController() {
            ad.present(fromRootViewController: controller){
                print("獲得獎勵")
            }
        }
    }
}
