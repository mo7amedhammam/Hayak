//
//  pickUpCellView.swift
//  Hayak
//
//  Created by wecancity on 31/08/2024.
//

import SwiftUI

struct pickUpCellModel : Hashable {
        var id : Int = 0
       var title : String = "Subway, Dubai World Trad Subway, Dubai World Trad"
       var subTitle : String = "Sandwiches, Beverages, Wraps"

    var image : String = "Sandwiches, Beverages, Wraps"
    var subImage : String = "od"
    
}

struct pickUpCellView: View {
    var pickUp : pickUpCellModel
    
//    @Binding var selectedResturant:restaurant
    
    var body: some View {

        VStack(spacing:0){
            ZStack (){
                KFImageLoader(urlStr: pickUp.image, placeholder: Image("pickupbgtest"))
                    .placeholder.resizable().scaledToFill()
                
                VStack{
                    HStack{
                            HStack(spacing:2){
                                Image(.clocklight)
                                    .resizable()
                                    .frame(width: 13, height: 13, alignment:.center)
                               
                                Group{
                                    Text("31")
                                    Text("mins")
                                }
                                    .foregroundColor(.main1)
                                    .font(.custom(fontEnum.regular.rawValue, size:10))

                            }
                        .padding(6)
                        
                        .background{Color.white.clipShape(Capsule())}
                        .borderRadius(.black25,width: 1, cornerRadius: 12, corners: .allCorners)

                        
                        HStack(spacing:2){
                            Image(.mapwithpin)
                                .resizable()
                                .frame(width: 13, height: 13, alignment:.center)
                           
                            Group{
                                Text("5.4")
                                Text("KM")
                            }
                                .foregroundColor(.main1)
                                .font(.custom(fontEnum.regular.rawValue, size:10))

                        }
//                        })
                    .padding(7)
                    .background{Color.white.clipShape(Capsule())}
                    .borderRadius(.black25,width: 1, cornerRadius: 12, corners: .allCorners)

                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(.unlove)
                        })
                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    Spacer()
                Text("Recommended by Hayak")
                    .foregroundColor(.white)
                    .padding(.horizontal,10)
                    .padding(.vertical,3)
                    .font(.custom(fontEnum.regular.rawValue, size:12))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background{Color.main}
            }
            }
//                                .frame(width: 70, height: 70, alignment: .center)
//                                .padding(10)
//                                .background{Color(selectedResturant == resturant ? "active text":"color-E5E5E5").cornerRadius(12)}
                            
            VStack(alignment: .leading,spacing: 5) {
                Text(pickUp.title)
                    .foregroundColor(.main1)
                    .font(.custom(fontEnum.regular.rawValue, size:12))
                    
                HStack {
                    Text(pickUp.subTitle)
                        .foregroundColor(.main2)
                    .font(.custom(fontEnum.regular.rawValue, size:10))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    VStack{
                        HStack(spacing:5){
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            
                            Text("4.5")
                                .foregroundColor(.black)
                                .font(.custom(fontEnum.light.rawValue, size:12))
                            
                            Text("( \(100)+)")
                                .foregroundColor(.main2)
                                .font(.custom(fontEnum.regular.rawValue, size:12))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(10)


            .borderRadius(.main,width: 1.2, cornerRadius: 12, corners: [.bottomLeft,.bottomRight])
            .padding(.horizontal,0.8)
            
            .overlay(content: {
                HStack{
                    Spacer()
                    KFImageLoader(urlStr: pickUp.subImage, placeholder: Image("od"))
                        .placeholder.resizable().frame(width: 70,height: 60).scaledToFill().cornerRadius(8)
                }
                .padding(.trailing,20)
                //                    .padding(.bottom,14)
                .offset(y:-50)
            })
        }
        .background(Color.white.cornerRadius(12))
//        .padding(.horizontal,4)
//        .padding(.bottom,4)
        .clipShape(.rect(cornerRadius: 12))
        
    }
}

#Preview {
    pickUpCellView(pickUp: pickUpCellModel.init())
        .frame(height:120)
}
