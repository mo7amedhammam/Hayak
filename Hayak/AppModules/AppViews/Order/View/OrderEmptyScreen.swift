//
//  OrderEmptyScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 12/08/2024.
//

import SwiftUI

struct OrderEmptyScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showOverlay: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Payment Methood" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
//                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                    showOverlay.toggle()
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewOrderEmptyScreen()
            }
        }
    }
}

#Preview {
    OrderEmptyScreen()
}


struct ExtractedViewOrderEmptyScreen: View {
    
    
    var body: some View {
        ScrollView {
            VStack (spacing : 10){
                
                Image("2")
                    .resizable()
                    .frame(width: 190 , height: 150)
                
                VStack {
                    
                    VStack(spacing : 15) {
                        Text("Your Cart is empty".localized())
                            .font(.custom("LamaSans-Bold", size: 18))
                            .foregroundColor(Color("main1"))
                        
                        Text("Looks like you haven't made your order yet.".localized())
                            .lineSpacing(10.0)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("main1"))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    CustomButton(Title:"Shop Now",IsDisabled: .constant(false), action: {
                        
                    })
                    .frame(height: 50)
                    .padding(.horizontal)
                    
                }
                Spacer()
            }
        }
    }
}
