//
//  StartView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/9.
//

import SwiftUI
import FirebaseAuth
import Kingfisher
struct StartView: View {
    @Binding var showStartView: Bool
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

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(showStartView: .constant(true))
    }
}
