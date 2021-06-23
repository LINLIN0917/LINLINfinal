//
//  SignInView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/8.
//

import SwiftUI

struct SignInView: View {
    @StateObject var signInViewModel = SignInViewModel()
    
    @State private var showSignUpView = false
    @State private var goAccountView = false
    
    @Binding var goSignInView: Bool
    
    //@State private var showSignAlert = false
    var body: some View {
        VStack{
            TextView(text1: NSLocalizedString("輸入帳號", comment: ""), text2: $signInViewModel.account)
            TextView(text1: NSLocalizedString("輸入密碼", comment: ""), text2: $signInViewModel.password)
            HStack{
                Button(action: {
                    signInAccount(account: signInViewModel.account, password: signInViewModel.password)
                    userSignIn()
                    goAccountView = true
                }, label: {
                    Text("sign in")
                })
                .fullScreenCover(isPresented: $goAccountView, content: {
                    AccountView(goAccountView: $goAccountView)
                })
                Button(action: {showSignUpView = true}, label: {
                    Text("sign up")
                })
                .fullScreenCover(isPresented: $showSignUpView, content: {
                    SignUpView(showSignUpView: $showSignUpView)
                })
                
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(goSignInView: .constant(true))
.previewInterfaceOrientation(.landscapeLeft)
    }
}
struct TextView: View {
    var text1: String
    @Binding var text2: String
    var body: some View {
        TextField("\(text1)", text: $text2)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            .padding()
    }
}
