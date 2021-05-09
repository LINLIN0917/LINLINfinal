//
//  SetView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/9.
//

import SwiftUI

struct SetPhotoView: View {
    @Binding var showSetView: Bool
    @State var index = 0.0
    var body: some View {
        VStack{
            ZStack{
            Circle()
                .fill(Color.purple)
                .frame(width: 100, height: 100)
                .overlay(
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 4)
                )
                Image(faces[Int(index)])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
            }
            Slider(value: $index, in: 0...60, step: 1)
            Button(action: {}, label: {
                Text("隨機設定")
            })
        }
    }
}

struct SetPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SetPhotoView(showSetView: .constant(true))
    }
}
