//
//  SIgnInViewModel.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/12.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var account: String = ""
    @Published var password: String = ""
    
    @Published var setAccount: String = ""
    @Published var setPassword: String = ""
}
class SignUpViewModel: ObservableObject {
    @Published var setName:String = ""
    @Published var setAccount: String = ""
    @Published var setPassword: String = ""
    @Published var age: Float = 18
    @Published var selectedIndex = 0
    var roles = ["台灣", "韓國", "中國", "日本"]
}
class SetPhotoViewModel: ObservableObject {
    @Published var chooseFace: String = "Awe"
    @Published var chooseColor: Color = .purple
    @Published var displayName = ""
}

