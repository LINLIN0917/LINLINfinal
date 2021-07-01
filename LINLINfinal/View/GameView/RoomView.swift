//
//  RoomView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/22.
//

import SwiftUI
import Kingfisher
import FirebaseAuth
import FirebaseFirestore
struct RoomView: View {
    @Binding var goRoomView: Bool
    @State var showGameView = false
    @StateObject var room2ViewModel = Room2ViewModel()
    
    @EnvironmentObject var roomViewModel: RoomViewModel
    var body: some View {
        ZStack{
            Image("BackGround")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
                       VStack{
                        Text("ROOM:\(roomViewModel.roomNumber)")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.orange)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.white, lineWidth: 5))
            //Text(String(roomViewModel.roomNumber))

            HStack{

              ForEach(0..<4){ index in
                VStack{
                    KFImage(URL(string: roomViewModel.photo[index]))
                   .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
               // Text(roomViewModel.name[index])
                    TextView2(text: roomViewModel.name[index])
                }
              }
            //Text(String(roomViewModel.number))
           .onAppear(perform: {
                let db = Firestore.firestore()
                db.collection("rooms").document(String(roomViewModel.roomNumber)).addSnapshotListener { snapshot, error in
                    
                    guard let snapshot = snapshot else { return }
                    guard let room = try? snapshot.data(as: Room.self) else { return }
                    roomViewModel.number = room.number
                    roomViewModel.photo[0] = room.photo[0]
                    roomViewModel.name[0] = room.player[0]
                    if roomViewModel.number > 1{
                    roomViewModel.photo[1] = room.photo[1]
                    roomViewModel.name[1] = room.player[1]
                    }
                    if roomViewModel.number > 2{
                    roomViewModel.photo[2] = room.photo[2]
                    roomViewModel.name[2] = room.player[2]
                    }
                    if roomViewModel.number > 3{
                    roomViewModel.photo[3] = room.photo[3]
                    roomViewModel.name[3] = room.player[3]
                    }
                
                    
                }
            })
            }
            //}
            HStack{
                Button(action: {}, label: {Text("Start Game")
                    
                })
                .buttonStyle(BlueButton())
                
                Button(action: {}, label: {Text("Ready")
                    
                })
                .buttonStyle(BlueButton())
                Button(action: {goRoomView = false}, label: {Text("back")
                })
                .buttonStyle(BlueButton())
                
            }
        }
        .fullScreenCover(isPresented: $showGameView, content: { GameView(showGameView: $showGameView)
        })
        }
    }
}


struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(goRoomView: .constant(true))
            .previewLayout(.fixed(width: 812, height: 375))
            .environmentObject(RoomViewModel())
        
    }
}
struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0.8, green: 0.5, blue: 0))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.white, lineWidth: 5))
    }
}
