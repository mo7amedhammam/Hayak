//
//  ChangePasswordScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 10/07/2024.
//

import SwiftUI

struct ChangePasswordScreen: View {
    
    @State private var passwordNumber: String = ""
    @State private var passwordPlaceholder: String = "Enter your new password "
    @State private var textLable: String           = "New password"
    @State private var image: String               = "eye"
    //
    @State private var confirmpasswordNumber: String = ""
    @State private var confirmpasswordPlaceholder: String = "Confirm your new password "
    @State private var confirmtextLable: String           = "Confirm new password"
    
    @State var isPasswordWrong : Bool = false
    @State var isPasswordWrongConfirm : Bool = false
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
           
                CustomHeaderView(title: "Reset New Password" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                }, onOtherBtn: {
                    
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                
                ScrollView {
                        VStack {
                            
                            PasswordView(passwordNumber: $passwordNumber, passwordPlaceholder: $passwordPlaceholder, textLable: $textLable, image: $image, isPasswordWrong: $isPasswordWrong)
                            
                            PasswordView(passwordNumber: $confirmpasswordNumber, passwordPlaceholder: $confirmpasswordPlaceholder, textLable: $confirmtextLable, image: $image, isPasswordWrong: $isPasswordWrongConfirm)

                            Button(action: {
                                //Save Now !
                                // go to reset
                                
                            }, label: {
                                Text("Save Now !")
                                    .frame(height: 50) // Set the height here
                                    .frame(maxWidth: .infinity)
                                    .font(.custom(fontEnum.medium.rawValue, size: 14))
                                    .foregroundColor(Color("bg1")).background(Color("main2"))
                                    .cornerRadius(20)
                                    .padding(.horizontal , 20)
                            })
                            
                           
                            
                            Spacer()
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity , minHeight: 300)
                        .background(.white)
                        .cornerRadius(20)
                        .padding(20)
                        
                        Spacer()
                    
                }
                


            }
            
        }.hideNavigationBar()
            .localizeView()
        
        
    }
}

#Preview {
    ChangePasswordScreen()
}
