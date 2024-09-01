//
//  MenueView.swift
//  Hayak
//
//  Created by wecancity on 01/09/2024.
//

import SwiftUI

struct MenueView: View {
    var body: some View {
                    VStack {
                        ZStack(alignment: .top){
                            Image(.re)
                                .resizable()
                                .frame(height: 195)
                                
                            
                            CustomPickupHeaderView(btnbackimg: Image(.circleback), onBack: {}, btnimg2:Image(.circlelove), onbtnimg2: {}, btnimg3: Image(.circleshare), onbtnimg3: {}, btnimg4: Image(.circlesearch), onbtnimg4: {},bgColor: .clear)
                                .padding(.top,UIDevice().hasNotch ? 50:20)

                        }
                        
                        VStack(spacing:15){
                            HStack{
                                KFImageLoader(urlStr: "pickUp.subImage", placeholder: Image("od"))
                                    .placeholder.resizable().frame(width: 72,height: 65).scaledToFill().cornerRadius(8)
                                
                                VStack(alignment:.leading,spacing: 7.5){
                                    Text("Mandarin Oak")
                                        .foregroundColor(.black)
                                        .font(.custom(fontEnum.bold.rawValue, size:14))
                                    
                                    Text("Chinese, Thai, Asian, Noodles, Dumplings")
                                        .foregroundColor(.black50)
                                    .font(.custom(fontEnum.bold.rawValue, size:10))
                                    
                                    HStack(spacing:2){
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                        
                                        Text("4.5")
                                            .foregroundColor(.black)
                                            .font(.custom(fontEnum.light.rawValue, size:12))
                                        
                                        Group {
                                            Text("(".localized())
                                            Text("\(100)")
                                            Text("Ratings".localized())
                                            Text(")".localized())


                                        }  
                                        .foregroundColor(.black50)
                                            .font(.custom(fontEnum.regular.rawValue, size:12))
                                    }
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                            }
                            
                            HStack{
                                infoLabel(title: "Distance",number: "5",measureunit: "KM")
                                infoLabel(title: "cooking time",number: "25",measureunit: "mins")
                                hayakRecommendLabel(title: "Recommended by")
                            }
                        }
                        .padding()
                        .background(.white)

                        .borderRadius(.black25,width: 1.2, cornerRadius: 12, corners: .allCorners)
                        .padding()
                        .offset(y:-95)
                        .padding(.bottom,-95)
                        
                        List{
                            Group{
                            HStack{
                                VStack(alignment: .leading,spacing:5){
                                    Text("Chicken Schezwan Fried Rice")
                                        .foregroundColor(.main1)
                                        .font(.custom(fontEnum.semiBold.rawValue, size:12))
                                    
                                    HStack(spacing:2){
                                        Text("220")
                                        Text("Calories".localized())
                                    }                                            .foregroundColor(.main2)
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
                                                
                                            }, label: {
                                                Image(.circleminus)
                                            })
                                            .frame(width: 15.3, height: 15.3, alignment: .center)
                                            
                                            Text("333")
                                                .foregroundStyle(.white)
                                                .font(.custom(fontEnum.bold.rawValue, size:12))
                                                .frame(maxWidth: .infinity,alignment: .center)

                                            Button(action: {
                                                
                                            }, label: {
                                                Image(.circleplus)
                                            })
                                            .frame(width: 15.3, height: 15.3, alignment: .center)
                                        }
                                        .frame(height:20)
                                        .frame(width:75)
                                        .padding(.horizontal,8)
//                                        .padding(.vertical,1.5)
                                        .background{ Color.main2.clipShape(Capsule())
                                        }
                                        .offset(y:10)
                                        .padding(.top,-10)

//                                        .offset(y:(gr.size.height/2)-3)
//                                        .padding(.top,-(gr.size.height/2)-3.5)
//                                    }
                                }
                                
                            }
                                customDivider()
                                    .padding(.horizontal,-30)
                                    .padding(.top,-20)

                        }
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .padding(5)


                        }
                        .listStyle(.plain)
//                        .padding(.horizontal)

                        
                        
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.top)                    .background{
                        Color(.white).ignoresSafeArea()
                            .navigationBarBackButtonHidden(true)
                    }
            }
}

#Preview {
    MenueView()
}
#Preview {
    MenueView()
}

struct infoLabel: View {
    var title:String
    var number:String?
    var measureunit:String?

    var body: some View {
        VStack(spacing:10){
            Text(title.localized())
                .foregroundColor(.main1)
                .font(.custom(fontEnum.light.rawValue, size:10))
            
            HStack(spacing:2) {
                Text("\(number ?? "5")")
                Text(measureunit?.localized() ?? "KM")
            }
            .foregroundColor(.main1)
            .font(.custom(fontEnum.semiBold.rawValue, size:10))
        }
        .padding(.horizontal)
        .frame(height: 67)
        .frame(maxWidth: .infinity)
        .background{Color.bg.cornerRadius(8)}
    }
}
struct hayakRecommendLabel: View {
    var title:String?

    var body: some View {
        VStack(spacing:10){
            Text(title?.localized() ?? "")
                .foregroundColor(.white)
                .font(.custom(fontEnum.light.rawValue, size:10))
            
            HStack(spacing:5){
                Image(.LOGO)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 40,height: 20)

                Image(.circleabout)
                    .resizable()
                    .frame(width: 16,height: 16)
            }
            .foregroundColor(.white)
        }
//        .padding(.horizontal)
        .frame(height: 67)
        .frame(maxWidth: .infinity)
        .background{Color.main2.cornerRadius(8)}
    }
}
