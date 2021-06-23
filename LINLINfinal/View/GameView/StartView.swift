//
//  StartView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/9.
//

import SwiftUI
import FirebaseAuth
import Kingfisher
struct StartView: View {
    
    @State private var goSignInView = false
    //let url = ""
    //@Binding var backSignInView: Bool
    var body: some View {
        ZStack{
            Image("BackGround")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            VStack{
                HStack{
                    Button(action: {goSignInView = true}, label: {
                        Text("Sign In")
                        
                            .padding(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 2.0)
                                    .shadow(color: .blue, radius: 10.0))
                    })
                        .fullScreenCover(isPresented: $goSignInView, content: {
                            SignInView(goSignInView: $goSignInView)
                        })
                        


                    
                    
                    Button(action: {goSignInView = true}, label: {
                        Text("See infomation")
                    })
                    
                    Button(action: {goSignInView = true}, label: {
                        Text("")
                    })
                    
                }
            }
            
        }
        .listStyle(InsetGroupedListStyle())
        
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
