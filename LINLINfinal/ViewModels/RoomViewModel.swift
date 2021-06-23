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
    var player: Int //人數
}
class RoomViewModel: ObservableObject {
    @Published var roomNumber: Int = 0
    @Published var searchNumber: String = ""
    
    func createRoom(number: String, leader: String) {
        let db = Firestore.firestore()
        
        let room = Room(leader: leader, player: 1)
        do {
            try db.collection("rooms").document("\(number)").setData(from: room)
            
        } catch {
            print(error)
        }
    }
    func loadRoom(number: String) {
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
    func modifyPlayer(number: String) {
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
                room.player += 1
              do {
                 try documentReference.setData(from: room)
              } catch {
                 print(error)
              }
                            
            }
    }
}
