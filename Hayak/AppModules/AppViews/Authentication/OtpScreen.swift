//
//  OtpScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 09/07/2024.
//

import SwiftUI

struct OtpScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var otp1: String = ""
    @State private var otp2: String = ""
    @State private var otp3: String = ""
    @State private var otp4: String = ""
    
    @FocusState private var focusedField: OTPField?
    @State private var otpFaild: Bool = false
    @State private var GoToResetPassword : Bool = false
    
    enum OTPField {
        case field1, field2, field3, field4
    }
    
    private let backgroundColor = Color("bg1")
    private let overlayColor    = Color("main1")
    private let textColor       = Color("main1")
    private let textColorError       = Color("wrong")

    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
         
                CustomHeaderView(title: "Forget Password" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                    
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                VStack(spacing: 20.0) {
                    
                    VStack {
                        Text("We will send you an ")
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                            .foregroundColor(Color("active text"))
                            .frame(height: 16)
                        Text("authentication code to your mobile")
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                            .foregroundColor(Color("active text"))
                            .frame(height: 16)
                        
                        Text(" number to reset your password")
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                            .foregroundColor(Color("active text"))
                            .frame(height: 16)
                    }
                    .padding(.top , 10)
                    
                    
                    HStack(spacing: 10) {
                        OTPTextField(text: $otp1, id: 1, backgroundColor: backgroundColor, overlayColor:  otpFaild ? textColorError : overlayColor, textColor: otpFaild ? textColorError : textColor , onCommit: {
                            focusedField = .field2 })
                            .focused($focusedField, equals: .field1)
                        OTPTextField(text: $otp2, id: 2, backgroundColor: backgroundColor, overlayColor:  otpFaild ? textColorError : overlayColor, textColor: otpFaild ? textColorError : textColor , onCommit: {
                            focusedField = .field3 })
                            .focused($focusedField, equals: .field2)
                        OTPTextField(text: $otp3, id: 3, backgroundColor: backgroundColor, overlayColor:  otpFaild ? textColorError : overlayColor, textColor: otpFaild ? textColorError : textColor , onCommit: {
                            focusedField = .field4 })
                            .focused($focusedField, equals: .field3)
                        OTPTextField(text: $otp4, id: 4, backgroundColor: backgroundColor, overlayColor:  otpFaild ? textColorError : overlayColor, textColor: otpFaild ? textColorError : textColor , onCommit: {
                            focusedField = nil })
                            .focused($focusedField, equals: .field4)
                    }
                    .padding()
                    .frame(height: 66)
                    
                    .onAppear {
                        focusedField = .field1
                    }
                    
                    
                    HStack {
                        Spacer()
                        Text("Not Yet Code")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                        Button(action: {
                            // Button action
                            print("Button tapped")
                            
                            
                        }) {
                            Text("Resend Now!")
                                .font(.custom(fontEnum.medium.rawValue, size: 14))
                                .foregroundColor(Color("main2"))
                        }
                        Spacer()
                        
                    }
                    .frame(height: 25)
                    .padding()
                    
                    Button(action: {
                        // Button action
                        print("Button tapped")
                        self.GoToResetPassword = true
                    }) {
                        Text("Send")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    }
                
                    
                    NavigationLink(
                        destination: ResetNewPasswordScreen().navigationBarBackButtonHidden(true),
                        isActive: $GoToResetPassword,
                        label: {
                            EmptyView()
                        }
                    )
                    
                }
                .frame(maxWidth: .infinity , minHeight: 400)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                Spacer()
                
                
            }
        }
    }
}

#Preview {
    OtpScreen()
}

struct OTPTextField: View {
    @Binding var text: String
    let id: Int
    let backgroundColor: Color
    let overlayColor: Color
    let textColor: Color
    @FocusState var isFocused: Bool
    var onCommit: () -> Void
    
    var body: some View {
        TextField("", text: $text)
            .frame(width: 66, height: 66)
            .foregroundColor(textColor)
            .background(backgroundColor).cornerRadius(10)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .focused($isFocused)
            .overlay(
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 2)
                        .padding(.horizontal , 5)
                        .foregroundColor(isFocused ? overlayColor : Color.clear)
                }
            )
        
            .onChange(of: text) { newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
                if newValue.count == 1 {
                    onCommit()
                }
            }
            .onAppear {
                if id == 1 {
                    isFocused = true
                }
            }
    }
}

