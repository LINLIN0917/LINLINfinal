//
//  ContentView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/4/14.
//

import SwiftUI
import FirebaseAuth
import Kingfisher
import FirebaseFirestore
import Firebase
struct AccountView: View {
    //let url = ""
    @State private var goRoomView = false
    @Binding var goAccountView: Bool
    @StateObject var roomViewModel: RoomViewModel
    var body: some View {
        List{
        ZStack{
            Image("BackGround")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
                .opacity(0.8)
        VStack{
            Text("PROFILE")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.orange)
                .overlay(
                    Rectangle()
                        .stroke(Color.white, lineWidth: 5))
            
            
                if let user = Auth.auth().currentUser { //如果有登入
                Group{
                
                    let url = user.photoURL
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                
                }
                    TextView2(text: "UID: \(user.uid)")
                    TextView2(text: "EMAIL: \(user.email!)")
                    TextView2(text: "NAME: \(user.displayName!)")
                                    Button(action: {roomViewModel.roomNumber = Int.random(in: 1...100)
                        let number = String(roomViewModel.roomNumber)
                        let url = user.photoURL!.absoluteString
                        roomViewModel.createRoom(number: number, leader: user.displayName!, photo: url)
                        goRoomView = true
                        
                    }, label: {Text("Create Room")
                })
                    .buttonStyle(BlueButton())
                HStack{
                    TextView(text1: "enter room number", text2: $roomViewModel.searchNumber)
                Button(action: {
                    let url = user.photoURL!.absoluteString
                    roomViewModel.roomNumber = Int(roomViewModel.searchNumber)!
                    roomViewModel.modifyPlayer(number: roomViewModel.searchNumber, name: user.displayName!, photo: url)
                    goRoomView = true
                }, label: {Text("Join Room")
                })
                .buttonStyle(BlueButton())
                    Button(action: {
                        do {
                           try Auth.auth().signOut()
                        } catch {
                           print(error)
                            
                        }
                        goAccountView = false
                    }, label: {Text("SignOut")
                    })
                   
                    .buttonStyle(BlueButton())
                    
                                    }
            }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .fullScreenCover(isPresented: $goRoomView, content: {
            RoomView(goRoomView: $goRoomView)
        })
        .environmentObject(roomViewModel)
        }
    }
}
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(goAccountView: .constant(true), roomViewModel: RoomViewModel())
            .previewLayout(.fixed(width: 812, height: 375))
    }
}
