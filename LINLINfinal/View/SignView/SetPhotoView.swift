//
//  SetView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/5/9.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
struct SetPhotoView: View {
    @Binding var showSetView: Bool
   @State private var backSignInView = false
   
    @StateObject var setPhotoViewModel = SetPhotoViewModel()
    @ObservedObject var signUpViewModel: SignUpViewModel
    @State private var upload = false
    @State private var showAlert = false
    @State private var showAlert2 = false
    var characterView: some View{
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 100, alignment: .center)

            Circle()
                .fill(setPhotoViewModel.chooseColor)
                .frame(width: 100, height: 100, alignment: .center)
                .overlay(
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 4)
                )
            Image(setPhotoViewModel.chooseFace)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
        }
    }
    var body: some View {
        ZStack{
            Image("BackGround")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
                .opacity(0.8)
        VStack{
            Text("SET CHARACTER")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.orange)
                .overlay(
                    Rectangle()
                        .stroke(Color.white, lineWidth: 5))

            HStack{
            characterView
                Spacer()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                VStack{
                        HStack{
                            TextView3(text: "face:")
                ForEach(0..<faces.count){ index in
                    Button(action: {setPhotoViewModel.chooseFace = faces[index]}, label: {
                        Image(faces[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                
                }
            }
            
            HStack{
                Text("color:")
                    .bold()
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: 100)
                    .background(Color.orange)
                ForEach(0..<colors.count){index in
                    Button(action: {setPhotoViewModel.chooseColor = colors[index] }, label: {
                        Circle()
                            .fill(colors[index])
                            .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay(Circle()
                                        .strokeBorder(Color.black, lineWidth: 4))
                    })
                }
            }
                }
            }
            Button(action: {let color1 = colors.randomElement()!
                let face1 = faces.randomElement()!
                setPhotoViewModel.chooseColor = color1
                setPhotoViewModel.chooseFace = face1
            }, label: {
                Text("random setting")
            })
            .buttonStyle(BlueButton())
            
           TextView(text1: "Name", text2: $setPhotoViewModel.displayName)
            HStack{
                Button(action: {showSetView = false}, label: {
                    Text("back")
                })
                .buttonStyle(BlueButton())
                Spacer()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {
                    upload = true
                    let uiimage = characterView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(uiimage, nil, nil, nil)
                    uploadPhoto(image: uiimage) { result in
                        switch result {
                        case .success(let url):
                            setUserPhoto(url: url, name: setPhotoViewModel.displayName)
                        case .failure(let error):
                           print(error)
                        }
                    }
                    showAlert2 = true

                }, label: {
                    Text("upload")
                })
                .alert(isPresented: $showAlert2) { () -> Alert in
                    return Alert(title: Text("Success"), message: Text("Finish Upload."), dismissButton: .cancel())}

                .buttonStyle(BlueButton())
Spacer()
    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {
                    if upload == true{
                    backSignInView = true
                    }
                    else{
                        showAlert = true
                    }
                    
                    }, label: {
                    Text("finish")
                })
                .buttonStyle(BlueButton())
                .alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: Text("Failed"), message: Text("You didn't upload your character."), dismissButton: .cancel())}
                .fullScreenCover(isPresented: $backSignInView, content: {
                                    SignInView(goSignInView: $backSignInView)})
            }
            
        }
            

        }
        
    }
}

struct SetPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SetPhotoView(showSetView: .constant(true), signUpViewModel: SignUpViewModel())
            .previewLayout(.fixed(width: 812, height: 375))
    }
}



struct TextView2: View {
    let text: String
    
    var body: some View {
        Text(text)
            .bold()
            .font(.title)
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: 600)
            .background(Color.orange)
    }
}
struct TextView3: View {
    let text: String
    
    var body: some View {
        Text(text)
            .bold()
            .font(.title)
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: 100)
            .background(Color.orange)
    }
}
