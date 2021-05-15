//
//  SignUpView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/8.
//

import SwiftUI
import FirebaseFirestore
struct SignUpView: View {
    @State private var account = ""
    @State private var password = ""
    @State private var name = ""
    @Binding var showSignUpView: Bool
    @State private var showSetView = false
    @State private var age: Float = 18
    var roles = ["台灣", "韓國", "中國", "日本"]
    @State private var selectedIndex = 0
    var body: some View {
        VStack{
            TextView(text1: "輸入名字", text2: $name)
            TextView(text1: "輸入email", text2: $account)
            TextView(text1: "輸入密碼", text2: $password)
            HStack{
                Text("年紀：\(Int(age))")
                Slider(value: $age, in: 0...60, step: 1)
                
            }
            Text("國家：")
            Picker(selection: $selectedIndex, label: Text("選擇國家")) {
                ForEach(roles.indices) { (index) in
                    Text(roles[index])
                }
            }
            HStack{
                Button(action: {
                    showSignUpView = false
                }, label: {
                    Text("返回")
                })
            Button(action: {
                creatAccount(account: account, password: password)
                createInfo(name: name, email: account, password: password, age: Int(age), country: roles[selectedIndex])
                showSetView = true
            }, label: {
                Text("下一步")
            })
            }
            EmptyView()
                .fullScreenCover(isPresented: $showSetView, content: {
                    SetPhotoView(showSetView: $showSetView)
                })
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUpView: .constant(true))
    }
}


