//
//  ContentView.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 28.11.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var isLogoShowing: Bool = true
    
    private var commonTopPadding: CGFloat {
        isLogoShowing ? 0 : 64
    }
    private let textFieldsMaxWidth: CGFloat = 220
    private let vkStandardColor: String = "VKStandard"
    private let vkWhiteColor: CGColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
    private let vkLogoName: String = "VK_Monochrome_Full_Logo"
    private let vkLogoWidth: CGFloat = 280
    
    private let isKeyboardShowingPub = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).map { _ in false},
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification).map { _ in true}
    )
    
    var body: some View {
        
        ZStack {
            
            Color(vkStandardColor)
                .ignoresSafeArea()
            
            VStack {
                if isLogoShowing {
                    Image(vkLogoName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: vkLogoWidth)
                        .padding(EdgeInsets(top: 64, leading: 0, bottom: 32, trailing: 0))
                }
                
                VStack {
                    HStack {
                        Text("Логин")
                            .foregroundColor(Color(vkWhiteColor))
                        Spacer()
                        TextField("Ведите логин", text: $login)
                            .frame(maxWidth: textFieldsMaxWidth)
                    }
                    HStack {
                        Text("Пароль")
                            .foregroundColor(Color(vkWhiteColor))
                        Spacer()
                        SecureField("Ведите пароль", text: $login)
                            .frame(maxWidth: textFieldsMaxWidth)
                    }
                }
                .frame(minWidth: 150, maxWidth: 300)
                .padding(EdgeInsets(top: commonTopPadding, leading: 0, bottom: 0, trailing: 0))
                
                Button(action: self.onLoginButtonPressed) {
                    HStack {
                        Text("Войти")
                            .foregroundColor(Color.white)
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.white)
                    }
                    
                }
                .padding([.top, .bottom], 30)
                .disabled(login.isEmpty || password.isEmpty)
                Spacer()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .onReceive(isKeyboardShowingPub) { value in
            withAnimation {
                self.isLogoShowing = !value
            }
        }
        .onTapGesture {
            endEditing()
        }
    }
    
    private func onLoginButtonPressed() {
        
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


