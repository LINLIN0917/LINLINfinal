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
import FirebaseStorage
import FirebaseStorageSwift
import SwiftUI

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
let faces = ["Awe", "Blank", "Angry with Fang", "Calm", "Cyclops", "Loving Grin 1", "Very Angry"]
let colors: [Color] = [.yellow, .blue, .gray, .green, .pink, .purple, .orange]


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


extension View { //截圖功能
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {//上傳檔案
        
        let fileReference = Storage.storage().reference().child(UUID().uuidString + ".jpg")
        if let data = image.jpegData(compressionQuality: 0.9) {
            
            fileReference.putData(data, metadata: nil) { result  in
                switch result {
                case .success(_):
                    fileReference.downloadURL { result in
                        switch result {
                        case .success(let url):
                            completion(.success(url))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

func setUserPhoto(url: URL, name: String) {//設定使用者頭像
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = url
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: { error in
           guard error == nil else {
               print(error?.localizedDescription)
               return
           }
        })
    
}
func setUserCharacterPhoto(){
    
    
}


