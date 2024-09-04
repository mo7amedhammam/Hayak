//
//  menueListCell.swift
//  Hayak
//
//  Created by wecancity on 03/09/2024.
//

import SwiftUI
struct menueListCell: View {
    @State var count = 0
    var onClick : (() ->  Void?)?
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading,spacing:5){
                    Text("Chicken Schezwan Fried Rice")
                        .foregroundColor(.main1)
                        .font(.custom(fontEnum.semiBold.rawValue, size:12))
                    
                    HStack(spacing:2){
                        Text("220")
                        Text("Calories".localized())
                    }
                    .foregroundColor(.main2)
                    .font(.custom(fontEnum.bold.rawValue, size:10))
                    
                    
                    Text("Golden fried Chicken pieces wok- tossed with hotand spicy schezwan fried rice with vegetables like green ...")
                        .foregroundColor(.main1)
                        .font(.custom(fontEnum.light.rawValue, size:11))
                        .lineLimit(3)
                        .lineSpacing(5)
                        .padding(.vertical,4)
                    
                    HStack(spacing:2){
                        Text("SAR".localized())
                        Text("123.00")
                        Spacer()
                        
                        Text("Customizable".localized())
                            .foregroundColor(.white)
                            .font(.custom(fontEnum.light.rawValue, size:10))
                            .padding(.horizontal,10)
                            .padding(.vertical,5)
                            .background{Color.main2.clipShape(Capsule())}
                        
                    }                                            .foregroundColor(.main2)
                        .font(.custom(fontEnum.bold.rawValue, size:10))
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                //                                Spacer()
                
                //                                GeometryReader{gr in
                ZStack(alignment:.bottom){
                    KFImageLoader(urlStr: "pickUp.subImage", placeholder: Image("od"))
                        .placeholder.resizable().frame(width: 111,height: 100).scaledToFill().cornerRadius(8)
                    HStack(alignment:.center,spacing:5){
                        
                        Button(action: {
                            guard count > 0 else {return}
                            count -= 1
                        }, label: {
                            Image(.circleminus)
                        })
                        .buttonStyle(.plain)
                        .frame(width: 15.3, height: 15.3, alignment: .center)
                        
                        Text(count,format: .number)
                            .foregroundStyle(.white)
                            .font(.custom(fontEnum.bold.rawValue, size:12))
                            .frame(maxWidth: .infinity,alignment: .center)
                        
                        Button(action: {
                            count += 1
                        }, label: {
                            Image(.circleplus)
                        })
                        .buttonStyle(.plain)
                        .frame(width: 15.3, height: 15.3, alignment: .center)
                    }
                    .frame(height:20)
                    .frame(width:75)
                    .padding(.horizontal,8)
                    .background{ Color.main2.clipShape(Capsule())
                    }
                    .offset(y:10)
                    .padding(.top,-10)
                    
                }
            }
            .onTapGesture {
                onClick?()
            }
            
            customDivider()
                .padding(.horizontal,-30)
                .padding(.top,10)
            
        }
        .padding(.top,-10)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}
