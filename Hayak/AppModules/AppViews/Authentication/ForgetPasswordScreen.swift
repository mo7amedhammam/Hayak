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
    @State var phoneNumber: String = ""

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
                
                VStack {
                    
                    VStack {
                        Text("We will send you an ")
                            .font(.custom("LamaSans-Medium", size: 13))
                            .foregroundColor(Color("active text"))
                            .frame(height: 16)
                        Text("authentication code to your mobile")
                            .font(.custom("LamaSans-Medium", size: 13))
                            .foregroundColor(Color("active text"))
                            .frame(height: 16)
                        
                        Text(" number to reset your password")
                            .font(.custom("LamaSans-Medium", size: 13))
                            .foregroundColor(Color("active text"))
                            .frame(height: 16)
                    }
                    .padding(.top , 20)
                    
                    
                    PhoneNumberView(phoneNumber: $phoneNumber)
                    
                    Button(action: {
                        //send
                        self.GoToOtp = true
                        
                    }, label: {
                        Text("Send")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom("LamaSans-Medium", size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(20)
                            .padding(.horizontal , 20)
                    })
                    
                    
                    NavigationLink(
                        destination: OtpScreen().navigationBarBackButtonHidden(true),
                        isActive: $GoToOtp,
                        label: {
                            EmptyView()
                        }
                    )
                    
                    
                }
                .frame(maxWidth: .infinity , minHeight: 300)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    ForgetPasswordScreen()
}
