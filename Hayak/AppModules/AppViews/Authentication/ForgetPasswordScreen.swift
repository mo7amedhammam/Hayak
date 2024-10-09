//
//  ForgetPasswordScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 08/07/2024.
//

import SwiftUI

struct ForgetPasswordScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var GoToOtp : Bool =  false
    @State var phoneNumber: String = "+966"

    @StateObject private var VMSendOtp = ViewModelSendOtp()
    @State private var showAlertOtp : Bool = false
    
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
                
                VStack {
                    
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
                    .padding(.top , 20)
                    
                    
                    PhoneNumberView(phoneNumber: $phoneNumber)
                    
                    Button(action: {
                        //send
                        UIApplication.shared.endEditing()
                        VMSendOtp.SendOtp(mobile: phoneNumber)
                        
                    }, label: {
                        Text("Send")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    })
                    
                    
                }
                .frame(maxWidth: .infinity , minHeight: 300)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                Spacer()
                
            }
            
            if VMSendOtp.isLoading {
                ProgressView("forget password...") // Show loading indicator
            }
            
            
            NavigationLink(
                destination: OtpScreen(fromScreen: "forgetpassword", mobile: phoneNumber, name: "", secondsCount: 0).navigationBarBackButtonHidden(true),
                isActive: $GoToOtp ,
                label: {
                    EmptyView()
                }
            )
            
            
        }
        
        // Show alert if there's an error
        .alert(isPresented: $showAlertOtp, content: {
            Alert(title: Text("Error"), message: Text(VMSendOtp.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK"), action: {
                // Reset errorMessage and showAlert when dismissed
                VMSendOtp.errorMessage = nil
                showAlertOtp = false
            }))
        })

        .onChange(of: VMSendOtp.errorMessage) { _ in
            if VMSendOtp.errorMessage != nil {
                showAlertOtp = true
                
            }
        }
        
        .onChange(of: VMSendOtp.OTPSuccess) { _ in
            GoToOtp = true
        }
        
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        
        
        
    }
}

#Preview {
    ForgetPasswordScreen()
}
