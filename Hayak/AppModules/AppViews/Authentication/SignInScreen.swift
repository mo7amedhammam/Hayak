//
//  SignInScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 06/07/2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ViewModelLogin()

    @State private var showAlert: Bool = false
    var hasnavbar:Bool? = true
    var body: some View {
        
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                if hasnavbar ?? true{
                    CustomHeaderView(title: "Sign in" , onBack: {
                        // Handle back button action
                        print("Back button pressed")
                    }, onOtherBtn: {
                        
                    }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                }
                
                ExtractedViewSignIn(viewModel: viewModel)
            }
                
            
          
        }.hideNavigationBar()
            .localizeView()
            .showHud(isShowing: $viewModel.isLoading, text: "sign in...")
        
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
        
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        
    }
}



#Preview {
    SignInScreen()
}

struct ExtractedViewSignIn: View {
    
    @StateObject  var viewModel : ViewModelLogin

    @State private var isChecked: Bool = false
    @State private var GoToSignUp: Bool = false
    @State private var GoToForgetPassword: Bool = false
//    @State private var GoToTabViewWithCenterBtn : Bool = false
    @State private var passwordNumber: String = ""
    @State private var passwordPlaceholder: String = "Enter your password"
    @State private var textLable: String           = "Password"
    @State private var image: String               = "password"
    
    @State var phoneNumber: String = "+966"
    @State var isPasswordWrong : Bool = false
    
    
    var body: some View {
        
        ScrollView {
            VStack (spacing : 0){
                
                VStack(alignment : .leading , spacing : 10) {
                    Image("LOGO")
                        .resizable()
                        .frame(width: 170 , height: 80)
                    Text("Welcome Back!")
                        .font(.custom("LamaSans-Bold", size: 18))
                        .foregroundColor(Color("main1"))
                    Text("Sign in to continue")
                        .font(.custom(fontEnum.medium.rawValue, size: 13))
                        .foregroundColor(Color("main1"))
                }
                .frame(maxWidth: .infinity , minHeight: 200 , alignment: .leading)
                .padding(.horizontal , 20)
                
                
                VStack {
                    
                    PhoneNumberView(phoneNumber: $phoneNumber)
                        .onChange(of: phoneNumber) { newValue in
                            if newValue.count < 4{
                                phoneNumber = "+966"
                            }
                        }
                    
                    
                    PasswordView(passwordNumber: $passwordNumber, passwordPlaceholder: $passwordPlaceholder, textLable: $textLable, image: $image, isPasswordWrong: $isPasswordWrong)
                    Spacer()
                    
                    HStack {
                        CheckboxView(isChecked: $isChecked)
                        Text("Remember me")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                        Spacer()
                        Button(action: {
                            // Button action
                            print("Button tapped")
                            GoToForgetPassword = true
                        }) {
                            Text("Forget password?")
                                .font(.custom(fontEnum.medium.rawValue, size: 14))
                                .foregroundColor(Color("main2"))
                        }
                    }
                    .frame(height: 25)
                    .padding()
                    
                    Button(action: {
                        UIApplication.shared.endEditing()
                        //Sign in
                        viewModel.Login(mobile: phoneNumber , password: passwordNumber)
                    }, label: {
                        Text("Sign in")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    })
                    
                    Spacer()
                    
                    
                    
                }
                .frame(maxWidth: .infinity , minHeight: 380)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                HStack (alignment: .center ){
                    Text("Already have not an account?")
                        .font(.custom(fontEnum.medium.rawValue, size: 14))
                        .foregroundColor(Color("main1"))
                    Button(action: {
                        // sign up
                        self.GoToSignUp = true
                    }, label: {
                        Text("Sign up!")
                            .frame(height: 50) // Set the height here
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("main2")).background(Color("bg"))
                    })
                    
                    
                    NavigationLink(
                        destination: SignUpScreen().navigationBarBackButtonHidden(true),
                        isActive: $GoToSignUp,
                        label: {
                            EmptyView()
                        }
                    )
                    
                    NavigationLink(
                        destination: ForgetPasswordScreen().navigationBarBackButtonHidden(true),
                        isActive: $GoToForgetPassword,
                        label: {
                            EmptyView()
                        }
                    )
                    
                    
//                    NavigationLink(
//                        destination: TabViewWithCenterBtn().navigationBarBackButtonHidden(true),
//                        isActive: $GoToTabViewWithCenterBtn ,
//                        label: {
//                            EmptyView()
//                        }
//                    )
                    
                } .frame(height: 80)
                
                Spacer()
            }
            
            
            .onChange(of: viewModel.loginSuccess) { newvalue in
                
                phoneNumber    = ""
                passwordNumber = ""
                if newvalue == true{
//                if  Helper.shared.CheckIfLoggedIn() {
                    Helper.shared.changeRoot(toView: TabViewWithCenterBtn())
//                    TabViewWithCenterBtn()
                } else {
                    viewModel.errorMessage = "try again"
                }
               
            }
                    
        }
    }
    
    
}

struct CheckboxView: View {
    @Binding var isChecked: Bool
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image( isChecked ? "selected" : "select")
        }
    }
}
