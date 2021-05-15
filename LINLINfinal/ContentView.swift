//
//  ContentView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/4/14.
//

import SwiftUI
import FirebaseAuth
import Kingfisher
struct ContentView: View {
    let url = ""
    
    var body: some View {
        VStack{
            
            List {
                if let user = Auth.auth().currentUser {
                Group{
                
                    let url = user.photoURL
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                
                }
                Text("\(user.uid)")
                    Text("\(user.email!)")
                    Text("\(user.displayName!)")
                }
            }
            .listStyle(InsetGroupedListStyle())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
