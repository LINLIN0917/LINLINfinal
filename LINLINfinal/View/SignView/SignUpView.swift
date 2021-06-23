//
//  SignUpView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/8.
//

import SwiftUI
import FirebaseFirestore
struct SignUpView: View {
    @StateObject var signUpViewModel = SignUpViewModel()
    
    //@State private var account = ""
    //@State private var password = ""
    //@State private var name = ""
    @State private var showSetView = false
    @Binding var showSignUpView: Bool
    //@State private var age: Float = 18
    //var roles = ["台灣", "韓國", "中國", "日本"]
    //@State private var selectedIndex = 0
    var body: some View {
        VStack{
            Form{
                TextView(text1: "name", text2: $signUpViewModel.setName)
                TextView(text1: "email", text2: $signUpViewModel.setAccount)
                TextView(text1: "password", text2: $signUpViewModel.setPassword)
                HStack{
                    Text("age：\(Int(signUpViewModel.age))")
                    Slider(value: $signUpViewModel.age, in: 1...60, step: 1)
                    
                }
                Text("country：")
                
                Picker(selection: $signUpViewModel.selectedIndex, label: Text("choose country")) {
                    ForEach(signUpViewModel.roles.indices) { (index) in
                        Text(signUpViewModel.roles[index])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Spacer()
            HStack{
                Button(action: {
                    showSignUpView = false
                }, label: {
                    Text("back")
                })
                Button(action: {
                    creatAccount(account: signUpViewModel.setAccount, password: signUpViewModel.setPassword)
                    createInfo(name: signUpViewModel.setName, email: signUpViewModel.setAccount, password: signUpViewModel.setPassword, age: Int(signUpViewModel.age), country: signUpViewModel.roles[signUpViewModel.selectedIndex])
                    
                    showSetView = true
                }, label: {
                    Text("next")
                })
            }
                .fullScreenCover(isPresented: $showSetView, content: {
                    SetPhotoView(showSetView: $showSetView)
                })
            
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUpView: .constant(true))
.previewInterfaceOrientation(.portrait)
    }
}


