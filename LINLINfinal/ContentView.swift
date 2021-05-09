//
//  ContentView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/4/14.
//

import SwiftUI


import Kingfisher
struct ContentView: View {
    var body: some View {
        let url = URL(string: "https://cdn2.ettoday.net/images/3268/d3268416.jpg")!
        return KFImage(url)
            .resizable()
            .scaledToFit()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
