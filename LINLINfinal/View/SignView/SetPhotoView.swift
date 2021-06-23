//
//  SetView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/9.
//

import SwiftUI

struct SetPhotoView: View {
    @Binding var showSetView: Bool
   @State private var backSignInView = false
   
    @StateObject var setUpViewModel = SetPhotoViewModel()
    
    @State private var showAlert = false
    var characterView: some View{
        ZStack{
            Circle()
                .fill(setUpViewModel.chooseColor)
                .frame(width: 100, height: 100, alignment: .center)
                .overlay(
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 4)
                )
            Image(setUpViewModel.chooseFace)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
        }
    }
    var body: some View {
        VStack{
            characterView
                        HStack{
                            Text("face:")
                ForEach(0..<faces.count){ index in
                    Button(action: {setUpViewModel.chooseFace = faces[index]}, label: {
                        Image(faces[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                }
            }
            
            HStack{
                Text("color:")
                ForEach(0..<colors.count){index in
                    Button(action: {setUpViewModel.chooseColor = colors[index] }, label: {
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
                setUpViewModel.chooseColor = color1
                setUpViewModel.chooseFace = face1
            }, label: {
                Text("random setting")
            })
            TextView(text1: "Name", text2: $setUpViewModel.displayName)
            HStack{
                Button(action: {showSetView = false}, label: {
                    Text("back")
                })
                Button(action: {
                    if setUpViewModel.displayName != ""{
                    let UIimage = characterView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(UIimage, nil, nil, nil)
                    uploadPhoto(image: UIimage) { result in
                        switch result {
                        case .success(let url):
                            setUserPhoto(url: url, name: setUpViewModel.displayName)
                        case .failure(let error):
                           print(error)
                        }
                    }
    
                        setUserCharacterPhoto()
                    }
                    else{
                        showAlert = true
                    }
                }, label: {
                    Text("upload")
                })

                Button(action: {
                    
                    if setUpViewModel.displayName != ""
                    {
                    backSignInView = true
                    
                    }
                    else{
                        showAlert = true
                    }
                }, label: {
                    Text("finish")
                })
            }
            .alert(isPresented: $showAlert) { () -> Alert in
                return Alert(title: Text("Failed"), message: Text("Name is empty."), dismissButton: .cancel())
             }
            .fullScreenCover(isPresented: $backSignInView, content: {
                SignInView(goSignInView: .constant(true))
            })

        }
        
    }
}

struct SetPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SetPhotoView(showSetView: .constant(true))
.previewInterfaceOrientation(.landscapeRight)
    }
}


