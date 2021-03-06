//
//  Test2View.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SecondView: View {
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        
        VStack {
            Image("peter")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .offset(offset)
            
            
        }
        .onAppear(perform: {
            let db = Firestore.firestore()
            
            db.collection("locations").document("peter").addSnapshotListener { snapshot, error in
                
                guard let snapshot = snapshot else { return }
                guard let location = try? snapshot.data(as: Location.self) else { return }
                offset = CGSize(width: location.x, height: location.y)
                
            }
        })
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
