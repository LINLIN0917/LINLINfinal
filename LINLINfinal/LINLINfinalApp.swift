//
//  LINLINfinalApp.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/4/14.
//

import SwiftUI

@main
struct LINLINfinalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SignInView(showSignInView: .constant(true))
        }
    }
}
