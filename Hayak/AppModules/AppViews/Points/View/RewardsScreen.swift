//
//  RewardsScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 03/09/2024.
//

import SwiftUI

struct RewardsScreen: View {
    
    @Environment (\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Rewards" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
//                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewRewardsScreen()
              
            }
        }    }
}

#Preview {
    RewardsScreen()
}


struct RewardsModel : Hashable {
    var tag : Int
    var name: String

    
    init(tag: Int, name: String) {
        self.tag = tag
        self.name = name
//        self.selected = selected
    }
}

struct ExtractedViewRewardsScreen : View {
    
    @State var emptyRewards: Bool = false
    @State private var items = [
        RewardsModel(tag : 0 ,name: "All"),
        RewardsModel(tag : 1 ,name: "Earned"),
        RewardsModel(tag : 2 ,name: "Redeemed"),
        RewardsModel(tag : 3 ,name: "Expired")
    ]
    @State var selecteditem : RewardsModel = RewardsModel(tag: 0, name: "All")
    
    var body: some View {
        
        VStack (spacing : 10) {
            
            VStack {
                ScrollView (.horizontal , showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(items,id: \.self){ item in
                            Button(action: {
                                selecteditem = item
//                                for i in 0..<items.count {
//                                    items[index].selected.wrappedValue = true
//                                    print("items[\(index)].selected : \(items[index].selected)")
//                                }
                            }, label: {
                                Text(item.name)
                                    .font(.custom(item == selecteditem ? fontEnum.medium.rawValue : fontEnum.bold.rawValue, size: 10))
                                    .padding()
                                    .background(item == selecteditem ? Color("main2") : Color("bg1"))
                                    .foregroundColor(item == selecteditem ? Color("main3") : Color("main1"))
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(item == selecteditem ? .clear : Color("main2"), lineWidth: 1)
                                    )
                            })
//                            .tag(items[index].tag)
                        }
                    }
                }
            }
            .padding()
            .frame(height: 55)
            .background(.clear)
         
            ZStack {
                List {
                    ForEach(0 ..< 10) {_ in
                        
                        VStack(spacing : 10) {
                            
                            HStack{
                                Text("subway")
                                    .font(.custom(fontEnum.bold.rawValue, size:12))
                                Spacer()
                                Text("+250")
                                    .font(.custom(fontEnum.bold.rawValue, size:12))
                            }
                            .foregroundColor(Color("main1"))
                            
                            
                            HStack{
                                Text("HO-125487-H1")
                                    .font(.custom(fontEnum.regular.rawValue, size:10))
                                Spacer()
                                Text("+250")
                                    .font(.custom(fontEnum.regular.rawValue, size:10))
                            }
                            .foregroundColor(Color("main2"))
                            
                            
                        }
                        .frame(height: 55)
                        
                        
                    }
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden) // Hide the separator lines
                
                
                
                if emptyRewards {
                    
                    VStack(spacing : 30) {
                        
                        Spacer()

                        Image("gift3")
                            .resizable()
                            .frame(width: 125 , height: 125)
                        
                        VStack(spacing : 3) {
                            Text("You Currently have no rewards history.")
                                .font(.custom(fontEnum.medium.rawValue, size:14))
                            Text("Order now to start earning points.")
                                .font(.custom(fontEnum.medium.rawValue, size:14))
                        }
                        .foregroundColor(Color("main1"))

                        
                        Button(action: {
                            //Order Now
                            
                        }, label: {
                            Text("Order Now")
                                .frame(height: 50) // Set the height here
                                .frame(maxWidth: .infinity)
                                .font(.custom(fontEnum.medium.rawValue, size: 14))
                                .foregroundColor(Color("bg1")).background(Color("main2"))
                                .cornerRadius(10)
                                .padding(.horizontal , 20)
                        })
                        
                        Spacer()

                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    
                }
                
                
                
                
                
                
            }
        }
    }
}
