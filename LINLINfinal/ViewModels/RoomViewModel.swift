//
//  RoomViewModel.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/22.
//

import Foundation


import Foundation
import FirebaseFirestore
import SwiftUI
import FirebaseFirestoreSwift

struct Room: Codable, Identifiable {
    @DocumentID var id: String? //房號
    var leader: String //室長
    var number: Int //人數
    var player: [String]
    var photo: [String]
    
}
class RoomViewModel: ObservableObject {
    @Published var roomNumber: Int = 0
    @Published var searchNumber: String = ""
    @Published var photo = [String](repeating: "", count: 4)
    @Published var number: Int = 0
    @Published var name = [String](repeating: "", count: 4)
    func createRoom(number: String, leader: String, photo: String) { //創立房間
        let db = Firestore.firestore()
        
        let room = Room(leader: leader, number: 1, player: [leader], photo: [photo])
        do {
            try db.collection("rooms").document("\(number)").setData(from: room)
            
        } catch {
            print(error)
        }
    }
    func loadRoom(number: String) { //載入房間
        let db = Firestore.firestore()
        db.collection("rooms").document(number).getDocument { document, error in
            
            guard let document = document,
                  document.exists,
                  let room = try? document.data(as: Room.self) else {
                      return
                  }
            print(room)
            
        }
    }
    func modifyPlayer(number: String, name: String, photo: String) { //加入房間
            let db = Firestore.firestore()
            let documentReference =
                db.collection("rooms").document(number)
            documentReference.getDocument { document, error in
                            
              guard let document = document,
                    document.exists,
                    var room = try? document.data(as: Room.self)
              else {
                        return
              }
                room.number += 1
                room.player.append(name)
                room.photo.append(photo)
              do {
                 try documentReference.setData(from: room)
              } catch {
                 print(error)
              }
                            
            }
    }
    
    func getUser(name: String) { //讀取使用者資料
        let db = Firestore.firestore()
        db.collection("info").document("\(name)").getDocument { document, error in
                    
             guard let document = document,
                   document.exists,
                   let info = try? document.data(as: ID.self) else {
                  return
             }
             print(info)
                 
        }
    }
    
}

class Room2ViewModel: ObservableObject {
    @Published var roomNumber: Int = 0
    @Published var photo: [String] = []
    @Published var number: Int = 0
    @Published var name: [String] = []
}
