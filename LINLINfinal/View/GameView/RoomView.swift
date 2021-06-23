//
//  RoomView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/22.
//

import SwiftUI

struct RoomView: View {
    @Binding var goRoomView: Bool
    var body: some View {
        VStack{
            //HStack{
            //}
        HStack{
            Button(action: {}, label: {Text("Start Game")
                
            })
            .buttonStyle(BlueButton())
            Button(action: {}, label: {Text("Ready")
                
            })
            .buttonStyle(BlueButton())
            Button(action: {goRoomView = false}, label: {Text("back")
                
            })
            .buttonStyle(BlueButton())
        }
        }
        
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(goRoomView: .constant(true))
.previewInterfaceOrientation(.landscapeLeft)
    }
}
struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0.8, green: 0.5, blue: 0))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
