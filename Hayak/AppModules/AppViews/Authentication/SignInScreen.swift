//
//  SignInScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 06/07/2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
            
                CustomHeaderView(title: "Sign in" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                    
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewSignIn()
            }
            
        }
    }
}



#Preview {
    SignInScreen()
}

struct ExtractedViewSignIn: View {
    @State private var isChecked: Bool = false
    @State private var GoToSignUp: Bool = false
    @State private var GoToForgetPassword: Bool = false
    
    @State private var passwordNumber: String = ""
    @State private var passwordPlaceholder: String = "Enter your password"
    @State private var textLable: String           = "Password"
    @State private var image: String               = "password"

    @State var phoneNumber: String = ""
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
                        .font(.custom("LamaSans-Medium", size: 13))
                        .foregroundColor(Color("main1"))
                }
                .frame(maxWidth: .infinity , minHeight: 200 , alignment: .leading)
                .padding(.horizontal , 20)
                
                
                VStack {
                    
                    PhoneNumberView(phoneNumber: $phoneNumber)
                    PasswordView(passwordNumber: $passwordNumber, passwordPlaceholder: $passwordPlaceholder, textLable: $textLable, image: $image, isPasswordWrong: $isPasswordWrong)
                    Spacer()
                    
                    HStack {
                        CheckboxView(isChecked: $isChecked)
                        Text("Remember me")
                            .foregroundColor(Color("main1"))
                            .font(.custom("LamaSans-Medium", size: 13))
                        Spacer()
                        Button(action: {
                            // Button action
                            print("Button tapped")
                            self.GoToForgetPassword = true
                        }) {
                            Text("Forget password?")
                                .font(.custom("LamaSans-Medium", size: 14))
                                .foregroundColor(Color("main2"))
                        }
                    }
                    .frame(height: 25)
                    .padding()
                                        
                    Button(action: {
                        //Sign in
                        
                    }, label: {
                        Text("Sign in")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom("LamaSans-Medium", size: 14))
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
                        .font(.custom("LamaSans-Medium", size: 14))
                        .foregroundColor(Color("main1"))
                    Button(action: {
                        // sign up
                        self.GoToSignUp = true
                    }, label: {
                        Text("Sign up!")
                            .frame(height: 50) // Set the height here
                            .font(.custom("LamaSans-Medium", size: 14))
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
                        isActive: $GoToForgetPassword ,
                        label: {
                            EmptyView()
                        }
                    )
                    
                } .frame(height: 80)
                
                Spacer()
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

struct PhoneNumberView: View {
    @Binding var phoneNumber: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Phone Number")
                .font(.custom("LamaSans-Bold", size: 12))
                .foregroundColor(Color("main1"))
            
            
            HStack {
                
                CustomTextField(
                    text: $phoneNumber,
                    placeholder: "Enter your phone number",
                    placeholderColor: UIColor(named: "empty text field") ?? .gray ,
                    textColor:  UIColor(named: "main1") ?? .black, keyboardType: .asciiCapableNumberPad
                ).font(.custom("LamaSans-Regular", size: 10))
                    .padding(.trailing, 32) // Add padding to make room for the icon
                    .overlay(
                        HStack {
                            Spacer()
                            Image("phone") // Replace with your desired icon
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


struct CustomTextfieldView: View {
    @Binding var textLable: String
    @Binding var text: String
    @Binding var title: String
    @Binding var image: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(textLable)
                .font(.custom("LamaSans-Bold", size: 12))
                .foregroundColor(Color("main1"))
            
            
            HStack {
                
                CustomTextField(
                    text: $text,
                    placeholder: title ,
                    placeholderColor: UIColor(named: "empty text field") ?? .gray ,
                    textColor:  UIColor(named: "main1") ?? .black, keyboardType: .asciiCapableNumberPad
                ).font(.custom("LamaSans-Regular", size: 10))
                    .padding(.trailing, 32) // Add padding to make room for the icon
                    .overlay(
                        HStack {
                            Spacer()
                            Image(image) // Replace with your desired icon
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


import SwiftUI

struct PasswordView: View {
    @Binding var passwordNumber: String
    @Binding var passwordPlaceholder: String
    @Binding var textLable: String
    @Binding var image: String

    @Binding var isPasswordWrong: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(textLable)
                .font(.custom("LamaSans-Bold", size: 12))
                .foregroundColor(Color("main1"))
            
            HStack {
                CustomSecureTextField(
                    text: $passwordNumber,
                    placeholder: passwordPlaceholder,
                    placeholderColor: UIColor(named: "empty text field") ?? .gray,
                    textColor:  (isPasswordWrong ? (UIColor(named: "wrong") ?? .black ) : UIColor(named: "main1") ?? .black)
                )
                .font(.custom("LamaSans-Regular", size: 10))
                .padding(.trailing, 32) // Add padding to make room for the icon
                .overlay(
                    HStack {
                        Spacer()
                        Image(image) // Replace with your desired icon
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



struct CustomHeaderView: View {
    var title: String
    var onBack: () -> Void
    var onOtherBtn: () -> Void
    
    var OtherBtnIsfound: Bool
     var imageonOtherBtn : String
     var coloronOtherBtn : String

    
    var body: some View {
        ZStack {
            // Background color or any other customization
            Color.white
                .edgesIgnoringSafeArea(.top)
                .frame(height: 70)
            
            // Content of the header
            HStack {
                // Back button
                Button(action: {
                    onBack()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.custom("LamaSans-Bold", size: 14))
                        .foregroundColor(Color("main1"))
                }
                .frame(width: 44) // The same width as the back button

                
                Spacer()
                
                // Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("main1"))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                if OtherBtnIsfound {
                    Button(action: {
                        onOtherBtn()
                    }) {
                        Image(imageonOtherBtn)
                            .font(.custom("LamaSans-Bold", size: 14))
                            .foregroundColor(Color(coloronOtherBtn))
                    }
                    .frame(width: 44) // The same width as the back button
                } else {
                    Spacer()
                        .frame(width: 44) // The same width as the back button
                    
                }
             
                
                
            }
//            .padding([.leading, .trailing])
            
            
        }
    }
}


struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField
        
        init(parent: CustomTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.parent.text = textField.text ?? ""
        }
    }
    
    @Binding var text: String
    var placeholder: String
    var placeholderColor: UIColor
    var textColor: UIColor
    var keyboardType : UIKeyboardType
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.textColor = textColor
        textField.keyboardType = keyboardType  // Set the keyboard type to number pad
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.textColor = textColor
        uiView.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

struct CustomSecureTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomSecureTextField

        init(parent: CustomSecureTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.parent.text = textField.text ?? ""
        }
    }

    @Binding var text: String
    var placeholder: String
    var placeholderColor: UIColor
    var textColor: UIColor

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.isSecureTextEntry = true // Enable secure text entry
        textField.textColor = textColor
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.textColor = textColor
        uiView.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
