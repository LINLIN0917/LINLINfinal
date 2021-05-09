//
//  BuildAccountFile.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/8.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ID: Codable, Identifiable { //使用者資料型別
    @DocumentID var id: String?
    let name: String
    let email: String
    let password: String
    let age: Int
    let country: String
}
struct Role {
    var face: String
    var color: String
}
var faces = ["Awe", "Blank", "Angry with Fang", "Calm", "Cyclops", "Loving Grin 1", "Very Angry"]


func creatAccount(account: String, password: String) { //註冊
    Auth.auth().createUser(withEmail: "\(account)", password: "\(password)") { result, error in
                
         guard let user = result?.user,
               error == nil else {
             print(error?.localizedDescription)
             return
         }
         print(user.email, user.uid)
    }
}
func signInAccount(account: String, password: String){ //登入
    Auth.auth().signIn(withEmail: "\(account)", password: "\(password)") { result, error in
         guard error == nil else {
            print(error?.localizedDescription)
            return
         }
    }
}
func userSignIn() { //判斷是否登入
    Auth.auth().addStateDidChangeListener { auth, user in
       if let user = user {
           print("\(user.uid) login")
       } else {
           print("not login")
       }
    }
}

func createInfo(name: String, email: String, password: String, age: Int, country: String) { //設定使用者資料
        let db = Firestore.firestore()
        
    let info = ID(name: "\(name)", email: "\(email)", password: "\(password)", age: age, country: "\(country)")
        do {
            let documentReference = try db.collection("info").addDocument(from: info)
            print(documentReference.documentID)
        } catch {
            print(error)
        }
}
func randomSet(){ //隨機設定人物
    
}
