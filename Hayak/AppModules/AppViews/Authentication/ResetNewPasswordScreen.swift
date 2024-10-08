//
//  ResetNewPasswordScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 10/07/2024.
//

import SwiftUI

struct ResetNewPasswordScreen: View {
    
    @Environment(\.presentationMode) var presentationMode

    @State private var passwordNumber: String = ""
    @State private var confirmPasswordNumber: String = ""

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
                
                ExtractedViewResetNewPasswordScreen()
            }
            
        }
    }
}

#Preview {
    ResetNewPasswordScreen()
}



struct ExtractedViewResetNewPasswordScreen: View {
    
    @State private var oldpasswordNumber: String = ""
    @State private var oldpasswordPlaceholder: String = "Enter your old password "
    @State private var oldtextLable: String           = "Old Password"
    //
    @State private var passwordNumber: String = ""
    @State private var passwordPlaceholder: String = "Enter your new password "
    @State private var textLable: String           = "New password"
    @State private var image: String               = "eye"
    //
    @State private var confirmpasswordNumber: String = ""
    @State private var confirmpasswordPlaceholder: String = "Confirm your new password "
    @State private var confirmtextLable: String           = "Confirm new password"
    
    @State var isPasswordWrongold : Bool = false
    @State var isPasswordWrong : Bool = false
    @State var isPasswordWrongConfirm : Bool = false
    
    @State var GoToChangePassword : Bool = false


    var body: some View {
        ScrollView {
                VStack {
                    
                    PasswordView(passwordNumber: $oldpasswordNumber, passwordPlaceholder: $oldpasswordPlaceholder, textLable: $oldtextLable, image: $image, isPasswordWrong: $isPasswordWrongold)
                    
                    PasswordView(passwordNumber: $confirmpasswordNumber, passwordPlaceholder: $confirmpasswordPlaceholder, textLable: $confirmtextLable, image: $image , isPasswordWrong : $isPasswordWrong)
                    
                    PasswordView(passwordNumber: $confirmpasswordNumber, passwordPlaceholder: $confirmpasswordPlaceholder, textLable: $confirmtextLable, image: $image , isPasswordWrong : $isPasswordWrongConfirm)


                    Button(action: {
                        //Save Now !
                        self.GoToChangePassword = true
                    }, label: {
                        Text("Save Now !")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    })
                    
                    NavigationLink(
                        destination: ChangePasswordScreen().navigationBarBackButtonHidden(true),
                        isActive: $GoToChangePassword,
                        label: {
                            EmptyView()
                        }
                    )
                    
                    
                    Spacer()                    
                    
                }
                .frame(maxWidth: .infinity , minHeight: 400)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                Spacer()
            
        }
    }
}


