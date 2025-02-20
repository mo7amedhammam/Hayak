//
//  ExViews.swift
//  MrS-Cool
//
//  Created by wecancity on 03/01/2024.
//

import Foundation
import SwiftUI

struct CornersRadious: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct CornersStroke: Shape {
        
        var radius: CGFloat = .infinity
        var corners: UIRectCorner = .allCorners
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    extension View {
        public func borderRadius<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat, corners: UIRectCorner) -> some View where S : ShapeStyle {
            let roundedRect = CornersStroke(radius: cornerRadius, corners: corners)
            return clipShape(roundedRect)
                .overlay(roundedRect.stroke(content, lineWidth: width))
        }
    }

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



struct PasswordView: View {
    @Binding var passwordNumber: String
    var passwordPlaceholder: String
    var textLable: String
    var image: String
    @Binding var isPasswordWrong: Bool
    
    @State private var isPasswordVisible: Bool = false // State to toggle password visibility
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(textLable.localized())
                .font(.custom("LamaSans-Bold", size: 12))
                .foregroundColor(Color("main1"))
            
            HStack {
                CustomSecureTextField(
                    text: $passwordNumber,
                    isSecure: .constant(!isPasswordVisible), // Pass negation of visibility state
                    placeholder: passwordPlaceholder,
                    placeholderColor: UIColor(named: "empty text field") ?? .gray,
                    textColor: (isPasswordWrong ? (UIColor(named: "wrong") ?? .black ) : UIColor(named: "main1") ?? .black)
                )
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.trailing, 32)
                
                Button(action: {
                    isPasswordVisible.toggle() // Toggle password visibility
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(Color("main1"))
                }
                .padding(.trailing, 8)
            }
            .padding(.vertical, 8)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.gray)
        }
        .padding(.all, 20)
        .frame(height: 100)
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



struct CustomHeaderView: View {
    @Environment(\.dismiss) var dismiss
    var title: String
    var hasBackBtn: Bool? = true
    var onBack: (() -> Void?)?
    var onOtherBtn: (() -> Void?)?
    
    var OtherBtnIsfound: Bool
    var imageonOtherBtn : String
    var coloronOtherBtn : String
    
    
    var body: some View {
        ZStack {
            // Background color or any other customization
            Color.white
                .edgesIgnoringSafeArea(.top)
                .frame(height: 60)
            
            // Content of the header
            HStack {
                // Back button
                
                if hasBackBtn == true{
                    Button(action: {
                        onBack?()
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.custom("LamaSans-Bold", size: 14))
                            .foregroundColor(Color("main1"))
                            .frame(width: 44) // The same width as the back button
                    }
                    .frame(width: 44) // The same width as the back button
                }else{
                    Spacer()
                        .frame(width: 44) // The same width as the back button
                }
                
                Spacer()
                
                // Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("main1"))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                if OtherBtnIsfound {
                    Button(action: {
                        onOtherBtn?()
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

