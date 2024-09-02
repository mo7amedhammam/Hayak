//
//  PointsScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 02/09/2024.
//

import SwiftUI

struct PointsScreen: View {
    
    @State var howItWork : Bool    = false
    
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            
            ScrollView {
                
                VStack(spacing : 20) {
                    
                    
                    Image("LOGO")
                        .resizable()
                        .frame(width: 90 , height: 45)
                    
                    
                    VStack {

                        HStack (spacing : 10){
                            Image("gift")
                                .resizable()
                                .frame(width: 50 , height: 50)
                            VStack(alignment : .leading,spacing : 11 )  {
                                
                                Text("1752 Points")
                                    .font(.custom(fontEnum.bold.rawValue, size: 18))
                                    .foregroundColor(Color("main1"))
                                
                                Text("Get 10 SR off from 1500 Points")
                                    .font(.custom(fontEnum.bold.rawValue, size: 10))
                                    .foregroundColor(Color("main2"))
                            }
                            Spacer()
                            Image("star")
                                .resizable()
                                .frame(width: 30 , height: 30)
                        }
                        .padding()
                    }
                    .frame(width: .infinity)
                    .frame(height: 80)
                    .background(Color("bg1"))
                    .overlay(
                        RoundedCorners(radius: 10, corners: .allCorners)
                            .stroke(Color("main3"), lineWidth: 1)
                    )
                    
                    
                    //............................................................
                    //............................................................
                    //............................................................
                    
                    
                    VStack(spacing : 10) {

                        HStack (spacing : 10){
                            Text("How it works?")
                                .font(.custom(fontEnum.bold.rawValue, size: 14))
                                .foregroundColor(Color("main1"))
                            Spacer()
                            Image(systemName: howItWork ?  "chevron.down" : "chevron.up")
                                .frame(width: 40 , height: 40)
                                .foregroundColor(Color("main2"))
                                .onTapGesture {
                                    howItWork.toggle()
                                }
                        }
                        .padding()
                        
                        
                        if howItWork {
                            
                            HowItWorkView(image: "checkout", title: "Order to earn ", description: "(SAVINGS UPTO 40%) Your Choice 1 Starter + 1 Rice or Noodles + 1 Main Course + 1 Complimentary Soup. ...")

                            Spacer()
                                .frame( height: 1)
                                .frame(maxWidth: .infinity)
                                .background(Color("main3"))
                                .padding(.horizontal , 10)
                            
                            
                            HowItWorkView(image: "search2", title: "Browse restaurants and stories", description: "(SAVINGS UPTO 40%) Your Choice 1 Starter + 1 Rice or Noodles + 1 Main Course + 1 Complimentary Soup. ...")
                            
                            Spacer()
                                .frame( height: 1)
                                .frame(maxWidth: .infinity)
                                .background(Color("main3"))
                                .padding(.horizontal , 10)
                            
                            HowItWorkView(image: "gift2", title: "Ready to redeem!", description: "(SAVINGS UPTO 40%) Your Choice 1 Starter + 1 Rice or Noodles + 1 Main Course + 1 Complimentary Soup. ...")
                            
                            Spacer()
                                .frame( height: 10)
                            
                        }
                    
                    }
                    .frame(width: .infinity)
                    .background(Color("bg1"))
                    .overlay(
                        RoundedCorners(radius: 10, corners: .allCorners)
                            .stroke(Color("main3"), lineWidth: 1)
                    )
                    
                    //............................................................
                    //............................................................
                    //............................................................

                    HStack()  {
                        Text("Restaurants")
                            .font(.custom(fontEnum.bold.rawValue, size: 14))
                            .foregroundColor(Color("main1"))
                        Spacer()
                    }
                    .frame(height: 30)
                    
                                      
                    ForEach(0 ..< 10) { item in
                        
                        ViewResturantCell2()
                    }
                    
                }
                .padding()
                
            }
        }
    }
}

#Preview {
    PointsScreen()
}



struct HowItWorkView : View {
    
    @State var image : String
    @State var title : String
    @State var description : String

    
    var body: some View {

        HStack (spacing : 10){
            Image(image)
                .frame(width: 50 , height: 50)
            VStack(alignment : .leading,spacing : 11 )  {
                
                Text(title)
                    .font(.custom(fontEnum.bold.rawValue, size: 12))
                    .foregroundColor(Color("main1"))
                
                Text(description)
                    .font(.custom(fontEnum.medium.rawValue, size: 9))
                    .foregroundColor(Color("main2"))
                    .lineSpacing(8.0)
                
            }
            Spacer()
        }
        
    }
}
