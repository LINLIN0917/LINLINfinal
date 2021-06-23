//
//  ContentView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/4/14.
//

import SwiftUI
import FirebaseAuth
import Kingfisher
struct AccountView: View {
    //let url = ""
    @State private var goRoomView = false
    @Binding var goAccountView: Bool
    @StateObject var roomViewModel = RoomViewModel()
    var body: some View {
        VStack{
            
            List {
                if let user = Auth.auth().currentUser {
                Group{
                
                    let url = user.photoURL
                    //KFImage(url)
                    Image("BackGround")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                
                }
                Text("\(user.uid)")
                    Text("\(user.email!)")
                    Text("\(user.displayName!)")
                    Button(action: {roomViewModel.roomNumber = Int.random(in: 1...100)
                        let number = String(roomViewModel.roomNumber)
                        roomViewModel.createRoom(number: number, leader: user.displayName!)
                        goRoomView = true
                    }, label: {Text("Create Room")
                })
                HStack{
                    TextView(text1: "enter room number", text2: $roomViewModel.searchNumber)
                Button(action: {
                    roomViewModel.modifyPlayer(number: roomViewModel.searchNumber)
                    goRoomView = true
                }, label: {Text("Join Room")
                })
                }
            }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .fullScreenCover(isPresented: $goRoomView, content: {
            RoomView(goRoomView: $goRoomView)
        })

        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(goAccountView: .constant(true))
.previewInterfaceOrientation(.landscapeLeft)
    }
}
