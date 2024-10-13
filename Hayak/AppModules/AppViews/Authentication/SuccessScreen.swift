//
//  SuccessScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 15/07/2024.
//

import SwiftUI

struct SuccessScreen: View {
    
    @State var name : String = ""
    @State var text1 : String = ""
    @State var text2 : String = ""
    @State var btnName : String = ""
    var onButtonClick: () -> Void = {}

    
    var body: some View {
        ZStack {
            
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            
            ScrollView {
                VStack {
                    
                    Image("done")
                        .frame(height: 200)
                    
                    
                    VStack(spacing : 10) {
                        Text("Hayak")
                            .font(.custom("LamaSans-Bold", size: 28))
                            .foregroundColor(Color("main2"))
                        Text(name)
                            .font(.custom("LamaSans-Bold", size: 17))
                            .foregroundColor(Color("main2"))
                            .padding(.bottom , 15)
                        
                        VStack(spacing : 10) {
                            Text(text1)
                                .font(.custom(fontEnum.medium.rawValue, size: 13))
                                .foregroundColor(Color("empty text field"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(6.0)
                            
                            Text(text2)
                                .font(.custom(fontEnum.medium.rawValue, size: 13))
                                .foregroundColor(Color("empty text field"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(6.0)
                        }
                        .padding(.horizontal , 40)
                        
                        
                        Button(action: {
                            onButtonClick()
                        }, label: {
                            Text(btnName)
                                .frame(height: 50) // Set the height here
                                .frame(maxWidth: .infinity)
                                .font(.custom(fontEnum.medium.rawValue, size: 14))
                                .foregroundColor(Color("bg1"))
                        })
                        .background(Color("main2")).cornerRadius(10)
                        .padding(.top , 30)
                        
                    }
                    .frame(maxWidth: .infinity , minHeight: 350)
                    .padding(.horizontal , 25)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(20)
                    
                }
            }    
        }.hideNavigationBar()
            .localizeView()
    }
}


#Preview {
    SuccessScreen()
}
