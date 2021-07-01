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
    var password: String
    var age: Int
    var country: String
    var photo: URL?
    
}

struct Role {
    var face: String
    var color: String
}
let faces = ["Awe", "Blank", "Angry with Fang", "Calm", "Cyclops", "Loving Grin 1", "Very Angry"]
let colors: [Color] = [.yellow, .blue, .gray, .green, .pink, .purple, .orange]

// 註冊相關功能
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

func userSignIn() -> Bool{ //判斷是否登入
        
    if let user = Auth.auth().currentUser {
        return true
        print("\(user.uid) login")
    } else {
        return false
        print("not login")
    }
    
}

func signOut() { //登出
    do {
        try Auth.auth().signOut()
    } catch {
        print(error)
    }
}
func createInfo(name: String, email: String, password: String, age: Int, country: String) { //設定使用者資料
    let db = Firestore.firestore()
    
    let info = ID(name: "\(name)", email: "\(email)", password: "\(password)", age: age, country: "\(country)", photo: URL(string: ""))
    do {
                    try db.collection("info").document("\(name)").setData(from: info)
                } catch {
                    print(error)
                }
}
func addPhoto(name: String, photo: URL) { //設立照片資料
    let db = Firestore.firestore()
            let documentReference =
                db.collection("info").document("\(name)")
            documentReference.getDocument { document, error in
                            
              guard let document = document,
                    document.exists,
                    var info = try? document.data(as: ID.self)
              else {
                        return
              }
                info.photo = photo
              do {
                 try documentReference.setData(from: info)
              } catch {
                 print(error)
              }
                            
            }
}


//截圖相關功能
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
    changeRequest?.displayName = name
    changeRequest?.photoURL = url
    changeRequest?.commitChanges(completion: { error in
        guard error == nil else {
            print(error?.localizedDescription)
            return
        }
    })
    }
func setUserName(name: String) {//設定使用者名字
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
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


