//
//  SettingsScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 01/08/2024.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        
        ZStack {
            VStack{
                
                VStack{
                    Spacer()
                    HStack (alignment: .bottom ) {
                        Image("menu")
                            .resizable()
                            .frame(width: 20 , height: 15)
                        Spacer()
                        Text("Notification")
                            .font(.custom("LamaSans-Bold", size: 14))
                            .foregroundColor( Color("main1"))
                        Spacer()
                        Spacer()
                            .frame(width: 40)
                    }
                    .frame(height: 60)
                    .padding(.horizontal , 15)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(.white)
                
                ScrollView {
                    VStack (spacing : 20){
                        
                        HStack (spacing : 20) {
                            Image("profile")
                                .resizable()
                                .frame(width: 50 , height: 50)
                            VStack (alignment : .leading , spacing: 20) {
                                Text("Jhon Smith")
                                    .font(.custom("LamaSans-Medium", size: 14))
                                    .foregroundColor( Color("main1"))
                                Text("Basic Member")
                                    .font(.custom("LamaSans-Medium", size: 13))
                                    .foregroundColor( Color("main2"))
                            }
                            Spacer()

                            Image("arrow")
                                .resizable()
                                .frame(width: 15 , height: 20)
                            
                        }
                        .padding()
                        .frame(height: 88)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(20)
                        
                        VStack (spacing : 0){
                            Text("Accounts")
                                .padding(.horizontal , 10)
                                .font(.custom("LamaSans-Bold", size: 18))
                                .frame(height: 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("main2"))
                                .foregroundColor(.white)
                            
                            Spacer()
                                .frame(height: 15)
                            
                            ExtractedViewSettings(imgTitle: "change-password", Title: "Change Password")
                                .onTapGesture {
                                    
                                }
                            ExtractedViewSettings(imgTitle: "order-management", Title: "Order Management")
                                .onTapGesture {
                                    
                                }
                            ExtractedViewSettings(imgTitle: "document", Title: "Document Management")
                                .onTapGesture {
                                    
                                }
                            ExtractedViewSettings(imgTitle: "payment", Title: "Payment")
                                .onTapGesture {
                                    
                                }
                            ExtractedViewSettings(imgTitle: "logout", Title: "Sign Out" , imgArrow : false)
                                .onTapGesture {
                                    
                                }

                            Text("More Options")
                                .padding(.horizontal , 10)
                                .font(.custom("LamaSans-Bold", size: 18))
                                .frame(height: 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("color-EBF4F4"))
                                .foregroundColor(Color("main2"))
                            
                            
                            Spacer()
                            
                        }
                        .frame(height: 700)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(20)
                        .padding(.vertical , 15)

                        Spacer()
                     
                    }
                    .frame(maxWidth: .infinity , maxHeight: .infinity)
                    .padding(.horizontal , 15)
                }
                
            }
            .background(Color("bg1"))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsScreen()
}

struct ExtractedViewSettings: View {
    var imgTitle : String = ""
    var Title : String = ""
    var imgArrow : Bool = true

    var body: some View {
        HStack (spacing : 16) {
            Image(imgTitle)
                .resizable()
                .frame(width: 22 , height: 25)
            Text(Title)
                .font(.custom("LamaSans-Medium", size: 15))
                .foregroundColor( Color("main1"))
            Spacer()
            Image(imgArrow ? "arrowEnable" : "" )
                .renderingMode(.template)
                .foregroundColor(Color("main1"))
                .frame(width: 20 , height: 50)
        }
        .frame(height: 65)
        .padding(.horizontal , 20)
    }
}
