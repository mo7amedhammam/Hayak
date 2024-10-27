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
    var pickUp : NearestBrandBrancheM
    var onSelect: (() -> Void)?
    var onClickLove: (() -> Void)?
    
    var body: some View {
        
        VStack(spacing:2.5){
            ZStack (){
                KFImageLoader(urlStr: pickUp.bannerURL, placeholder: Image("pickupbgtest"))
                    .placeholder.resizable().scaledToFill()
                    .frame(height: 120)
                    .scaledToFill()
//                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)

                VStack{
                    HStack{
                        HStack(spacing:2){
                            Image(.clocklight)
                                .resizable()
                                .frame(width: 13, height: 13, alignment:.center)
                            
                            Group{
                                Text("31")
                                Text("mins".localized())
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
                                Text(pickUp.distance ?? 0,format:.number.precision(.fractionLength(1)))
                                Text("KM".localized())
                            }
                            .foregroundColor(.main1)
                            .font(.custom(fontEnum.regular.rawValue, size:10))
                            
                        }
                        .padding(7)
                        .background{Color.white.clipShape(Capsule())}
                        .borderRadius(.black25,width: 1, cornerRadius: 12, corners: .allCorners)
                        
                        Spacer()
                        
                        Button(action: {
                            onClickLove?()
                        }, label: {
                            Image(pickUp.favourite ?? false ? .unlove:.love)
                        })
                        
                    }
                    .padding(.horizontal)
                    .padding(.top,10)
                    Spacer()
                    if pickUp.isRecommended == true{
                        Text("Recommended by Hayak".localized())
                            .foregroundColor(.white)
                            .padding(.horizontal,10)
                            .padding(.vertical,3)
                            .font(.custom(fontEnum.regular.rawValue, size:12))
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background{Color.main}
                    }
                }
            }
            
            VStack(alignment: .leading,spacing: 5) {
                Text(pickUp.branchName ?? "")
                    .foregroundColor(.main1)
                    .font(.custom(fontEnum.regular.rawValue, size:12))
                
                HStack {
                    Text(pickUp.resturantType ?? "")
                        .foregroundColor(.main2)
                        .font(.custom(fontEnum.regular.rawValue, size:10))
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    VStack{
                        HStack(spacing:5){
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            
                            Text(pickUp.rate ?? 0,format: .number.precision(.fractionLength(1)))
                                .foregroundColor(.black)
                                .font(.custom(fontEnum.light.rawValue, size:12))
                            
                            Text("( \(pickUp.ratingCount ?? 0)+)")
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
                    KFImageLoader(urlStr: pickUp.bannerURL, placeholder: Image("od"))
                        .placeholder.resizable()
                        .frame(width: 70,height: 60).scaledToFill().cornerRadius(8)
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
        .onTapGesture(perform: {
            onSelect?()
        })
        
    }
}

#Preview {
    pickUpCellView(pickUp: NearestBrandBrancheM.init())
        .frame(height:120)
}

