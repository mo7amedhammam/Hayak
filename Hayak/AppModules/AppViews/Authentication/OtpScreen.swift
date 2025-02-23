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
    @State private var otp5: String = ""
    @State private var otp6: String = ""
    
    @FocusState private var focusedField: OTPField?
    @State private var otpFaild: Bool = false
    @State private var GoToResetPassword : Bool = false
    @State private var GoToSignin : Bool = false
    
    enum OTPField {
        case field1, field2, field3, field4, field5, field6
    }
    
    private let backgroundColor = Color("bg1")
    private let overlayColor    = Color("main1")
    private let textColor       = Color("main1")
    private let textColorError       = Color("wrong")
    
    let fromScreen : String
    let mobile: String // Accept mobile number as a parameter
    let name: String // Accept mobile number as a parameter
    
    var secondsCount: Int?
    var code: Int?
    
    @StateObject private var viewModel = ViewModelVertifyOtp() // Initialize the ViewModel
    @StateObject private var VMResendOtp = ViewModelSendOtp()// Initialize the ViewModel

    @State private var showAlert = false
    
    
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                CustomHeaderView(title: "Forget Password" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                }, onOtherBtn: {
                    
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                VStack(spacing: 20.0) {
                    
                    VStack {
                        Text("OTP Verification")
                            .font(.custom(fontEnum.bold.rawValue, size: 18))
                            .foregroundColor(.main1)
                            .frame(height: 16)
                            .padding(.vertical , 20)
                        Text("An authentication code has been sent to")
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                            .foregroundColor(.emptyTextField)
                            .frame(height: 16)
                        
                        Text("\(mobile)")
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                            .foregroundColor(.emptyTextField)
                            .frame(height: 16)
                        
                        Text(viewModel.secondsCount > 0 ? "\(viewModel.code ?? 0)" : "")
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                            .foregroundColor(.emptyTextField)
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
                            focusedField = .field5 })
                        .focused($focusedField, equals: .field4)
                        
                        
                        OTPTextField(text: $otp5, id: 5, backgroundColor: backgroundColor, overlayColor:  otpFaild ? textColorError : overlayColor, textColor: otpFaild ? textColorError : textColor , onCommit: {
                            focusedField = .field6 })
                        .focused($focusedField, equals: .field5)
                        
                        OTPTextField(text: $otp6, id: 6, backgroundColor: backgroundColor, overlayColor:  otpFaild ? textColorError : overlayColor, textColor: otpFaild ? textColorError : textColor , onCommit: {
                            focusedField = nil })
                        .focused($focusedField, equals: .field6)
                        
                        
                    }
                    .padding()
                    .frame(height: 66)
                    
                    .onAppear {
                        focusedField = .field1
                    }
                    
                    
                    HStack {
                        Spacer()
                        Text("I didn't receive code.")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.medium.rawValue, size: 13))
                        
                        Button(action: {
                            // Button action
                            print("Button tapped")
                            // sond mobile number to send new Otp from send otp then call sendotp function to update new otp and fire new timer
                            
                            viewModel.code           = 0
                            viewModel.secondsCount   = 0
                            VMResendOtp.code         = 0
                            VMResendOtp.secondsCount = 0
                            VMResendOtp.SendOtp(mobile: mobile)

                            
                        }) {
                            Text("Resend Now!")
                                .font(.custom(fontEnum.medium.rawValue, size: 14))
                                .foregroundColor(Color("main2"))
                        }
                        .disabled(viewModel.secondsCount > 0 ?  true : false)
                        Spacer()
                        
                    }
                    .frame(height: 25)
                    .padding()
                    
                    
                    Text(viewModel.secondsCount > 0 ? "\(viewModel.timeRemaining) Sec left" : "")
                        .foregroundColor(.main1)
                        .font(.custom(fontEnum.medium.rawValue, size: 14))
                    
                    
                    Button(action: {
                        // Button action
                        print("Button tapped")
                        viewModel.VertifyOtp(otp: "\(otp1)\(otp2)\(otp3)\(otp4)\(otp5)\(otp6)", mobile: mobile)
                        
                    }) {
                        Text("Send")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    }
                    
                }
                .frame(maxWidth: .infinity , minHeight: 400)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                Spacer()
                
                
            }
            
            
            
            NavigationLink(
                destination: ResetNewPasswordScreen(mobile: mobile).navigationBarBackButtonHidden(true),
                isActive: $GoToResetPassword,
                label: {
                    EmptyView()
                }
            )
            
            
            
            if GoToSignin {
                SuccessScreen(name: name , text1: "Your account had beed created successfully.", text2: "Please sign in to use your account and enjoy", btnName: "Take me to sign in") {
                    
                    GoToSignin = false  // Close the SuccessScreen
                    navigateToSignIn()  // Handle navigation to SignInScreen
                    
                }
            }
            
            
            NavigationLink(destination: SignInScreen().navigationBarBackButtonHidden(true) , isActive: $GoToSignin) {
                
            }
            
        }.hideNavigationBar()
            .localizeView()
            .showHud(isShowing: $viewModel.isLoading, text: "OTP Verification...")
            .showHud(isShowing: $VMResendOtp.isLoading, text: "Resend OTP...")

        
        
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
                    
                    focusedField = .field1
                    otp1 = ""
                    otp2 = ""
                    otp3 = ""
                    otp4 = ""
                    otp5 = ""
                    otp6 = ""
                }
            }
        
            .onChange(of: viewModel.OTPSuccess) { success in
                if success {
                    // Navigate to the OTP screen once signUpSuccess is true
                    if fromScreen == "signup" {
                        GoToSignin = true
                    } else if fromScreen == "forgetpassword" {
                        GoToResetPassword = true
                    } else  {
                        GoToResetPassword = true
                    }
                }
            }
            .task {
                viewModel.secondsCount =  secondsCount ?? 0
                viewModel.code =  code
            }
        //        .onAppear {
        //            viewModel.secondsCount =  secondsCount
        //            viewModel.code =  code
        //        }
        
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        
        
        
        // Show alert if there's an error VMResendOtp
        //...............................................................
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Error"), message: Text(VMResendOtp.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK"), action: {
                    // Reset errorMessage and showAlert when dismissed
                    VMResendOtp.errorMessage = nil
                    showAlert = false
                }))
            })
        
            .onChange(of: VMResendOtp.errorMessage) { _ in
                if VMResendOtp.errorMessage != nil {
                    showAlert = true
                    focusedField = .field1
                    otp1 = ""
                    otp2 = ""
                    otp3 = ""
                    otp4 = ""
                    otp5 = ""
                    otp6 = ""
                }
            }
        
            .onChange(of: VMResendOtp.OTPSuccess) { success in
                if success {
                    focusedField = .field1
                    otp1 = ""
                    otp2 = ""
                    otp3 = ""
                    otp4 = ""
                    otp5 = ""
                    otp6 = ""
                    
                    viewModel.secondsCount = VMResendOtp.secondsCount
                    viewModel.code         = VMResendOtp.code
                    
                }
            }
        //...............................................................
        
        
        
        
        
        
        
    }
    
    
    func navigateToSignIn() {
        GoToSignin = true  // Set this to true to trigger navigation
    }
    
}

#Preview {
    OtpScreen(fromScreen: "", mobile: "" , name: "", secondsCount: 0,code: 0)
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
            .frame(height: 66)
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

