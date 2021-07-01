//
//  AppDelegate.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/4/14.
//
import UIKit
import Firebase
import AVFoundation
import GoogleMobileAds
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
       // AVPlayer.setupBgMusic()
        //AVPlayer.bgQueuePlayer.play()
        GADMobileAds.sharedInstance().start(completionHandler: nil) //廣告
        
        return true
    }
   

}
