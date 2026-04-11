//
//  PickUpCheckoutCell.swift
//  Hayak
//
//  Created by wecancity on 28/10/2024.
//

import SwiftUI

struct CartItem: Identifiable {
    let id = UUID()
    // Add more properties as needed (e.g., name, price, etc.)
}

struct PickUpCheckoutCell: View {
    
   @State var plusMinus  = 1
    
    
    var body: some View {
        
        HStack(spacing : 10) {
            
            VStack(alignment : .leading , spacing : 10) {
                
                Text("Pink Risotto")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:14))
                
                Text("SAR 66.00")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:12))
                
                Text("Your Choice of Sauce")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.regular.rawValue, size:10))
                
                Text("Spicy Sauce")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:10))
                
                Text("Pasta Sauce (+7 SAR)")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:10))
                Text("Your Choice of Sandwich")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.regular.rawValue, size:10))
                Text("Spicy (+15 SAR)")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:10))
                Text("Your Choice of Drink")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.regular.rawValue, size:10))
                Text("Cola")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:10))
                
            }
            Spacer()
            
            VStack (spacing : -10){
                Image("od")
                    .resizable()
                    .frame(width: 100 , height: 100)
                HStack {
                    Image(systemName: "plus")
                        .frame(width: 20 , height: 20 )
                        .foregroundColor(.white)
                        .onTapGesture {
                            plusMinus += 1
                        }
                    Spacer()
                    Text("\(plusMinus)")
                        .foregroundColor(.white)
                        .font(.custom(fontEnum.regular.rawValue, size:16))
                    Spacer()
                    
                    Image(systemName: "minus")
                        .frame(width: 20 , height: 20 )
                        .foregroundColor(.white)
                        .onTapGesture {
                            plusMinus -= 1
                        }
                }
                .padding(.horizontal , 10)
                .frame(width: 100 , height: 25)
                .background(Color("main2"))
                .cornerRadius(15)
                
                Spacer()
                
            }
            .frame(width: 120)
            
        }
        .padding(.vertical , 10)
        .frame(height: 200)
    }
}

#Preview {
    PickUpCheckoutCell()
}
