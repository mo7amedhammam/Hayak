//
//  menueItemDetails.swift
//  Hayak
//
//  Created by wecancity on 03/09/2024.
//

import SwiftUI

struct menueItemDetails: View {
    
    @State var count = 0
    @Binding var isPresented:Bool
    
    var iscustomizable : Bool? = true
    
    var body: some View {
        VStack(spacing:15){
            ZStack(alignment: .topTrailing) {
                Image(.re)
                    .resizable()
                    .frame(height: 206)
                    .scaledToFill()
                
                
                    .borderRadius(.clear, cornerRadius: 16, corners: .allCorners)
                
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(8)
                        .background{
                            Color.black.clipShape(Circle()).opacity(0.3)
                        }
                }
                .frame(height: 40)
                .padding(5)
            }
            
            HStack{
                Text("Shrimp Dumplings")
                    .foregroundColor(.main1)
                    .font(.custom(fontEnum.bold.rawValue, size:18))
                Spacer()
                
                Text("220 Calories")
                    .foregroundColor(.main2)
                    .font(.custom(fontEnum.semiBold.rawValue, size:12))
                
            }
            Text("The shrimp dumpling is made of shrimp\n and wrapped with a translucent wrapper.")
                .foregroundColor(.main2)
                .font(.custom(fontEnum.regular.rawValue, size:14))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            Text("SAR 31.00")
                .foregroundColor(.main2)
                .font(.custom(fontEnum.semiBold.rawValue, size:12))
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            if let iscustomizable {
                ScrollView(showsIndicators: false){
                    ForEach(1..<10,id: \.self){_ in
                        Text("Shrimp Dumplings")
                            .foregroundColor(.main1)
                            .font(.custom(fontEnum.bold.rawValue, size:18))
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity,alignment: .center)

            }
            
            HStack{
                HStack(alignment:.center,spacing:5){
                    
                    Button(action: {
                        guard count > 0 else {return}
                        count -= 1
                    }, label: {
                        Image(systemName: "minus")
                            .font(Font.system(size: 12))
                            .frame(width: 23, height: 23, alignment: .center)
                            .foregroundColor(.main1)
                            .background(.main2.opacity(0.3))
                            .clipShape(Circle())
                    })
                    .buttonStyle(.plain)
                    
                    Text(count,format: .number)
                        .foregroundStyle(.main1)
                        .font(.custom(fontEnum.bold.rawValue, size:12))
                        .frame(maxWidth: .infinity,alignment: .center)
                    
                    Button(action: {
                        count += 1
                    }, label: {
                        Image(systemName: "plus")
                            .font(Font.system(size: 12))
                            .frame(width: 23, height: 23, alignment: .center)
                            .foregroundColor(.main3)
                            .background(.main2)
                            .clipShape(Circle())
                        
                        
                    })
                    .buttonStyle(.plain)
                }
                .frame(height:50)
                .frame(width:111)
                .padding(.horizontal,8)
                .background{ Color.main3.borderRadius(.clear, cornerRadius: 12, corners: .allCorners)
                }
                
                Button(action: {
                    guard count > 0 else {return}
                    count -= 1
                }, label: {
                    HStack {
                        Text("Add".localized())
                        Spacer()
                        
                        Text("SAR".localized())
                        
                        Text(count*13,format: .number)
                        
                    }
                    .font(.custom(fontEnum.regular.rawValue, size:14))
                    .foregroundColor(.white)
                    .padding()
                    
                })
                .buttonStyle(.plain)
                .frame(height:50)
                .background{ Color.main2.borderRadius(.clear, cornerRadius: 12, corners: .allCorners)
                }
                
                
            }
            
            
        }
        
    }
}

#Preview {
    menueItemDetails( isPresented: .constant(true))
}
