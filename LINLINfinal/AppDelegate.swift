//
//  AppDelegate.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/4/14.
//
import UIKit
import Firebase
import AVFoundation
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        //AVPlayer.setupBgMusic()
       // AVPlayer.bgQueuePlayer.play()
        
        return true
    }
}
