//
//  SignUpScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 08/07/2024.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Sign up", onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()

                })
                ExtractedViewSignUp()
            }
            
        }
    }
}

#Preview {
    SignUpScreen()
}


struct ExtractedViewSignUp: View {
    @State var isChecked : Bool = false
    @Environment(\.presentationMode) var presentationMode

    
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
                        .font(.custom("LamaSans-Medium", size: 13))
                        .foregroundColor(Color("main1"))
                }
                .frame(maxWidth: .infinity , minHeight: 200 , alignment: .leading)
                .padding(.horizontal , 20)

                
                VStack {
                    
                    UserNameView()
                    PhoneNumberView()
                    PasswordView()
                    ConfirmPasswordView()

                    Spacer()
                    
                    HStack {
                        CheckboxView(isChecked: $isChecked)
                        Text("By creating an account you agree to our Terms of Service and Privacy Policy")
                            .foregroundColor(Color("main1"))
                            .font(.custom("LamaSans-Medium", size: 13))
                            .multilineTextAlignment(.leading)
                            
                     
                    }
                    .frame(height: 40)
                    .padding()
                                        
                    Button(action: {
                        //Sign Up
                        
                    }, label: {
                        Text("Sign Up")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom("LamaSans-Medium", size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    })
                    
                    Spacer()
                    
                    HStack (alignment: .center ){
                        Text("Already have not an account?")
                            .font(.custom("LamaSans-Medium", size: 14))
                            .foregroundColor(Color("main1"))
                        Button(action: {
                            // sign in
                            presentationMode.wrappedValue.dismiss()

                        }, label: {
                            Text("Sign in!")
                                .frame(height: 50) // Set the height here
                                .font(.custom("LamaSans-Medium", size: 14))
                                .foregroundColor(Color("main2"))
                        })
                        
                    } .frame(height: 100)
                    
                    
                    
                }
                .frame(maxWidth: .infinity , minHeight: 500)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
            
            }
        }
    }
}



struct UserNameView: View {
    @State private var userName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Name")
                .font(.custom("LamaSans-Bold", size: 12))
                .foregroundColor(Color("main1"))
            
            
            HStack {
                
                CustomTextField(
                    text: $userName,
                    placeholder: "Enter your name",
                    placeholderColor: UIColor(named: "empty text field") ?? .gray ,
                    textColor:  UIColor(named: "main1") ?? .black , keyboardType: .default
                ).font(.custom("LamaSans-Regular", size: 10))
                    .padding(.trailing, 32) // Add padding to make room for the icon
                    .overlay(
                        HStack {
                            Spacer()
                            Image("user") // Replace with your desired icon
                                .foregroundColor(Color("AAAAAA"))
                                .padding(.trailing, 8)
                        }
                    )
            }
            .padding(.vertical, 8)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.gray)
        }
        .padding(.all, 20)
        .frame(height: 100) // Set the desired height here
    }
}


struct ConfirmPasswordView: View {
    @State private var ConfirmpasswordNumber: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Confirm Password")
                .font(.custom("LamaSans-Bold", size: 12))
                .foregroundColor(Color("main1"))
            
            
            HStack {
                
                CustomSecureTextField(
                    text: $ConfirmpasswordNumber,
                    placeholder: "Confirm your password",
                    placeholderColor: UIColor(named: "empty text field") ?? .gray ,
                    textColor:  UIColor(named: "main1") ?? .black
                )
                .font(.custom("LamaSans-Regular", size: 10))
                .padding(.trailing, 32) // Add padding to make room for the icon
                .overlay(
                    HStack {
                        Spacer()
                        Image("password") // Replace with your desired icon
                            .foregroundColor(Color("AAAAAA"))
                            .padding(.trailing, 8)
                    }
                )
            }
            .padding(.vertical, 8)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.gray)
        }
        .padding(.all, 20)
        .frame(height: 100) // Set the desired height here
    }
}
