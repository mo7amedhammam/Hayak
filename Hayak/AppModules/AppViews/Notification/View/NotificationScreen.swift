//
//  NotificationScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 01/08/2024.
//

import SwiftUI

struct NotificationScreen: View {
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
                                
                List {
                    ForEach(0..<10) { item in
                        
                            HStack (spacing : 20) {
                                Image("noti")
                                    .resizable()
                                    .frame(width: 50 , height: 50)
                                VStack (alignment : .leading , spacing: 20) {
                                    Text("order cancel")
                                        .font(.custom("LamaSans-Bold", size: 12))
                                        .foregroundColor( Color("main1"))
                                    Text("order#132 has been canceled")
                                        .font(.custom("LamaSans-Medium", size: 13))
                                        .foregroundColor( Color("main1"))
                                }
                            }
                        .frame(width: .infinity , height: 88)
                        .background(.white)
                        .cornerRadius(40)
                        
                    }
                }
                .padding(.horizontal, 15) // Add vertical padding between cells
                .listStyle(.plain)
                .listRowSpacing(10)
                .listRowSeparator(.hidden, edges: .all)
            }
            .background(Color("bg1"))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    NotificationScreen()
}
