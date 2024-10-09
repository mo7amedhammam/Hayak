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
    
    let mobile : String
    @StateObject private var viewModel = ViewModelResetPasssword()
    @State private var GoToSignin : Bool = false
    @State var showAlert = false
    
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
                
                ExtractedViewResetNewPasswordScreen(viewModel: viewModel, mobile: mobile)
            }
            
            if viewModel.isLoading {
                ProgressView("reset password...") // Show loading indicator
            }
            
            if GoToSignin {
                SuccessScreen(name: "" , text1: "", text2: "Your Password Reset!", btnName: "Take me to sign in") {
                    GoToSignin = false  // Close the SuccessScreen
                    navigateToSignIn()  // Handle navigation to SignInScreen
                }
            }
            
            NavigationLink(destination: SignInScreen().navigationBarBackButtonHidden(true) , isActive: $GoToSignin) {
            }
            
        }
        
        // Show alert if there's an error
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK"), action: {
                // Reset errorMessage and showAlert when dismissed
                viewModel.errorMessage = nil
                showAlert = false
            }))
        })
        
        .onChange(of: viewModel.errorMessage) { _ in
            if viewModel.errorMessage != nil {
                showAlert = true
            }
        }
        .onChange(of: viewModel.resetSuccess) { _ in
            GoToSignin = true
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        
    }
    
    func navigateToSignIn() {
        GoToSignin = true  // Set this to true to trigger navigation
    }
}

#Preview {
    ResetNewPasswordScreen(mobile: "")
}



struct ExtractedViewResetNewPasswordScreen: View {
    
    @StateObject  var viewModel : ViewModelResetPasssword // Initialize the ViewModel
    @State private var showAlert = false
    let mobile : String
    
    @State private var passwordNumber: String        = ""
    @State private var confirmpasswordNumber: String = ""
    
    @State private var passwordPlaceholder: String        = "Enter your new password "
    @State private var confirmpasswordPlaceholder: String = "Confirm your new password "
    
    @State private var textLable: String         = "New password"
    @State private var confirmtextLable: String  = "Confirm new password"
    
    @State private var image: String               = "eye"
    
    @State var isPasswordWrong : Bool        = false
    @State var isPasswordWrongConfirm : Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                PasswordView(passwordNumber: $passwordNumber, passwordPlaceholder: $passwordPlaceholder, textLable: $textLable, image: $image , isPasswordWrong : $isPasswordWrong)
                
                PasswordView(passwordNumber: $confirmpasswordNumber, passwordPlaceholder: $confirmpasswordPlaceholder, textLable: $confirmtextLable, image: $image , isPasswordWrong : $isPasswordWrongConfirm)
                
                Button(action: {
                    //Save Now !
                    UIApplication.shared.endEditing()
                    viewModel.ResetPasssword(mobile: mobile , newPassword: passwordNumber, ConfirmPassword: confirmpasswordNumber)
                    
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
            .frame(maxWidth: .infinity , minHeight: 400)
            .background(.white)
            .cornerRadius(20)
            .padding(20)
            
            Spacer()
            
        }
    }
}


