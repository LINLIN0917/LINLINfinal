//
//  GameView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/22.
//

import SwiftUI

struct GameView: View {
    @Binding var showGameView: Bool
    var body: some View {
        
        Image("BackGround")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(showGameView: .constant(true))
    }
}
