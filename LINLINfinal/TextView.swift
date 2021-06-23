//
//  TextFile.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/20.
//

import SwiftUI

import SwiftUI
import FirebaseStorage
import FirebaseStorageSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Location: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    var x: CGFloat
    var y: CGFloat
}

struct ContentView: View {
    
    func setLocation(location: Location) {
        let db = Firestore.firestore()
            
        do {
            try db.collection("locations").document(location.name).setData(from: location)
        } catch {
            print(error)
        }
    }
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        
        VStack {
            Image("peter")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .offset(offset)
            
            Button(action: {
                
                offset.width += 5
                setLocation(location: Location(name: "peter", x: offset.width, y: offset.height))
                
            }, label: {
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
            })
            
            Button(action: {
                
                offset.height -= 5
                setLocation(location: Location(name: "peter", x: offset.width, y: offset.height))

            }, label: {
                Image(systemName: "chevron.up.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
