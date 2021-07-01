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
        List{
        ZStack{
            Image("BackGround")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            
        VStack{
            Text("SIGN UP")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.orange)
                .overlay(
                    Rectangle()
                        .stroke(Color.white, lineWidth: 5))
            
                TextView(text1: "Enter your name", text2: $signUpViewModel.setName)
                TextView(text1: "Enter your email", text2: $signUpViewModel.setAccount)
                TextView(text1: "Enter your password", text2: $signUpViewModel.setPassword)
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
        
        }
            HStack{
                Spacer()
                    .frame(width: 300, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {
                    showSignUpView = false
                }, label: {
                    Text("back")
                })
                .buttonStyle(BlueButton())
                
                Button(action: {
                    
                    creatAccount(account: signUpViewModel.setAccount, password: signUpViewModel.setPassword)
                    createInfo(name: signUpViewModel.setName, email: signUpViewModel.setAccount, password: signUpViewModel.setPassword, age: Int(signUpViewModel.age), country: signUpViewModel.roles[signUpViewModel.selectedIndex])
                    
                    showSetView = true
                }, label: {
                    Text("next")
                })
                .buttonStyle(BlueButton())
            }
                .fullScreenCover(isPresented: $showSetView, content: {
                    SetPhotoView(showSetView: $showSetView, signUpViewModel: SignUpViewModel())
                })
            
    }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUpView: .constant(true))
            .previewLayout(.fixed(width: 812, height: 375))
    }
}


