//
//  SignUpScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 08/07/2024.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var viewModel = ViewModelCreate() // Initialize the ViewModel
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var email = ""
    @State private var address = ""
    @State private var cityId = 1 // You can use a picker to select the city
    @State private var genderId = 1 // Assume gender can be chosen with a picker
    @State private var birthDate = "1990-01-01" // Example birthdate, could use a DatePicker
    @State private var creationDate = "2024-09-16"
    @State private var isChecked = false

    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
          
                CustomHeaderView(title: "Sign up" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                    
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewSignUp(isChecked: $isChecked , viewModel: viewModel, name: $name, phoneNumber: $phoneNumber, password: $password, confirmPassword: $confirmPassword, email: $email, address: $address, cityId: $cityId, genderId: $genderId, birthDate: $birthDate, creationDate: $creationDate)
                
                
            }
            
            if viewModel.isLoading {
                ProgressView("Signing Up...") // Show loading indicator
            }
            
        }
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
        
        
    }
}

#Preview {
    SignUpScreen()
}


struct ExtractedViewSignUp: View {
    @Binding var isChecked : Bool
    @Environment(\.presentationMode) var presentationMode

//    @State private var passwordNumber: String = ""
    @State private var passwordPlaceholder: String = "Enter your password"
    @State private var textLable: String           = "Password"
    @State private var image: String               = "password"
    
//    @State private var confirmpasswordNumber: String = ""
    @State private var confirmpasswordPlaceholder: String = "Confirm your password "
    @State private var confirmtextLable: String           = "Confirm password"
    
//    @State var phoneNumber : String = ""
    
    @State var isPasswordWrong : Bool = false
    @State var isPasswordWrongconfirm : Bool = false

    
    @ObservedObject var viewModel: ViewModelCreate // Observing ViewModel
    @Binding var name: String
    @Binding var phoneNumber: String
    @Binding var password: String
    @Binding var confirmPassword: String
    
    @Binding var email: String
    @Binding var address: String
    @Binding var cityId: Int
    @Binding var genderId: Int
    @Binding var birthDate: String
    @Binding var creationDate: String
    
    
    
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
                    
                    UserNameView(userName: $name)
                    PhoneNumberView(phoneNumber: $phoneNumber)
                    PasswordView(passwordNumber: $password, passwordPlaceholder: $passwordPlaceholder, textLable: $textLable, image: $image, isPasswordWrong: $isPasswordWrong)
                    PasswordView(passwordNumber: $confirmPassword, passwordPlaceholder: $confirmpasswordPlaceholder, textLable: $confirmtextLable, image: $image, isPasswordWrong: $isPasswordWrongconfirm)

                    Spacer()
                    
                    HStack {
                        CheckboxView(isChecked: $isChecked)
                        Text("By creating an account you agree to our Terms of Service and Privacy Policy")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                            .multilineTextAlignment(.leading)
                            
                     
                    }
                    .frame(height: 40)
                    .padding()
                                        
                    Button(action: {
                        //Sign Up
                        if password == confirmPassword {
                            // Call ViewModel's Create function when button is pressed
                            viewModel.Create(name: name, mobile: phoneNumber, genderId: genderId, birthDate: birthDate, email: email, address: address, cityId: cityId, creationDate: creationDate, passwordHash: password)
                        }
                        
                    }, label: {
                        Text("Sign Up")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    })
                    
                    Spacer()
                    
                    HStack (alignment: .center ){
                        Text("Already have not an account?")
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("main1"))
                        Button(action: {
                            // sign in
                            presentationMode.wrappedValue.dismiss()

                        }, label: {
                            Text("Sign in!")
                                .frame(height: 50) // Set the height here
                                .font(.custom(fontEnum.medium.rawValue, size: 14))
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
    @Binding  var userName: String
    
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
