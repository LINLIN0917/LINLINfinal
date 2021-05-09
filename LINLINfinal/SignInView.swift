//
//  SignInView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/8.
//

import SwiftUI

struct SignInView: View {
    @State private var account = ""
    @State private var password = ""
    @State private var showSignUpView = false
    //@State private var showSignAlert = false
    var body: some View {
        VStack{
            TextView(text1: "輸入帳號", text2: $account)
            TextView(text1: "輸入密碼", text2: $password)
            HStack{
                Button(action: {
                    signInAccount(account: account, password: password)
                    userSignIn()
                }, label: {
                    Text("登入")
                })
                Button(action: {showSignUpView = true}, label: {
                    Text("註冊")
                })
                EmptyView()
                .fullScreenCover(isPresented: $showSignUpView, content: {
                    SignUpView(showSignUpView: $showSignUpView)
                })
                
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
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
