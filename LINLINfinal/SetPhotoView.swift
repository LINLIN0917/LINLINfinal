//
//  SetView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/9.
//

import SwiftUI

struct SetPhotoView: View {
    @Binding var showSetView: Bool
    @State private var chooseFace: String = "Awe"
    @State private var chooseColor: Color = .purple
    @State private var showSignInView = false
    @State private var displayName = ""
    var characterView: some View{
        ZStack{
            Circle()
                .fill(chooseColor)
                .frame(width: 100, height: 100)
                .overlay(
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 4)
                )
            Image(chooseFace)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
        }
    }
    var body: some View {
        VStack{
            characterView
            Text("臉型")
            HStack{
                
                ForEach(0..<faces.count){ index in
                    Button(action: {chooseFace = faces[index]}, label: {
                        Image(faces[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                }
            }
            Text("顏色")
            HStack{
                ForEach(0..<colors.count){index in
                    Button(action: {chooseColor = colors[index] }, label: {
                        Circle()
                            .fill(colors[index])
                            .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay(Circle()
                                        .strokeBorder(Color.black, lineWidth: 4))
                    })
                }
            }
            
            Button(action: {let color1 = colors.randomElement()!
                let face1 = faces.randomElement()!
                chooseColor = color1
                chooseFace = face1
            }, label: {
                Text("隨機設定")
            })
            TextView(text1: "輸入暱稱", text2: $displayName)
            HStack{
                Button(action: {showSetView = false}, label: {
                    Text("返回")
                })
                Button(action: {
                    let UIimage = characterView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(UIimage, nil, nil, nil)
                    uploadPhoto(image: UIimage) { result in
                        switch result {
                        case .success(let url):
                            setUserPhoto(url: url, name: displayName)
                        case .failure(let error):
                           print(error)
                        }
                    }
                showSignInView = true
                    setUserCharacterPhoto()
                }, label: {
                    Text("設定完成")
                })
            }
            .fullScreenCover(isPresented: $showSignInView, content: {
                SignInView(showSignInView: $showSignInView)
            })
        }
    }
}

struct SetPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SetPhotoView(showSetView: .constant(true))
    }
}


