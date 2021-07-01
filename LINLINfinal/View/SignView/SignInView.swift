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
    @State private var showAlert = false
    //@State private var showSignAlert = false
    var body: some View {
        ZStack{
            Image("BackGround")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
                       VStack{
                        Text("SIGN IN")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.orange)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.white, lineWidth: 5))
            TextView(text1: NSLocalizedString("Enter your email", comment: ""), text2: $signInViewModel.account)
            TextView(text1: NSLocalizedString("Enter your password", comment: ""), text2: $signInViewModel.password)
            HStack{
                Button(action: {
                    signInAccount(account: signInViewModel.account, password: signInViewModel.password)
                    let user = userSignIn()
                    
                    if user == true {
                        goAccountView = true
                    }
                    else{
                        showAlert = true
                    }
                }, label: {
                    Text("sign in")
                })
                .alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: Text("Failed"), message: Text("Cannot Find your account or password, please check your enter."), dismissButton: .cancel())}
                .buttonStyle(BlueButton())
                .fullScreenCover(isPresented: $goAccountView, content: {
                    AccountView(goAccountView: $goAccountView, roomViewModel: RoomViewModel())
                })
                Spacer()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {showSignUpView = true}, label: {
                    Text("sign up")
                })
                .buttonStyle(BlueButton())
                .fullScreenCover(isPresented: $showSignUpView, content: {
                    SignUpView(showSignUpView: $showSignUpView)
                })
                
            }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(goSignInView: .constant(true))
            .previewLayout(.fixed(width: 812, height: 375))
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
