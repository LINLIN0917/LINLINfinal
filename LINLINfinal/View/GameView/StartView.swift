//
//  StartView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/9.
//

import SwiftUI
import FirebaseAuth
import Kingfisher
import GoogleMobileAds
struct StartView: View {
    
    @State private var goSignInView = false
    //let url = ""
    //@Binding var backSignInView: Bool
    let rewardedAdController = RewardedAdController()
    var body: some View {
        ZStack{
            Image("BackGround")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            VStack{
                Text("Taiwanese Food Monopoly")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.orange)
                    .overlay(
                        Rectangle()
                            .stroke(Color.white, lineWidth: 5))
                Spacer()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 80)
                
                    Button(action: {goSignInView = true}, label: {
                        Text("START")
                        })
                    .buttonStyle(BlueButton())
                Button(action: {rewardedAdController.loadAd()}, label: {
                    Text("Load Ad")
                    })
                .buttonStyle(BlueButton())
                Button(action: {rewardedAdController.showAd()}, label: {
                    Text("Show Ad")
                    })
                .buttonStyle(BlueButton())
                    
                        .fullScreenCover(isPresented: $goSignInView, content: {
                            SignInView(goSignInView: $goSignInView)
                        })
                        

                Spacer()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20)
                    
                    
            //        Button(action: {goSignInView = true}, label: {
              //          Text("See infomation")
              //      })
                //    .buttonStyle(BlueButton())
                    
                    
                
            }
            
        }
        .listStyle(InsetGroupedListStyle())
        
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewLayout(.fixed(width: 812, height: 375))
            .environmentObject(RoomViewModel())

    }
}
