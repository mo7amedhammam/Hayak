//
//  MenueView.swift
//  Hayak
//
//  Created by wecancity on 01/09/2024.
//

import SwiftUI

struct MenueView: View {
    
    @State var isSheetPresented = false
    @State var basketitemscount = 0
    @State var basketitemsprice = 0
    
    var categories : [restaurant] = [restaurant(id: 1, name: "Trending", imageUrl: "2"),restaurant(id: 2, name: "Free Soup", imageUrl: nil),restaurant(id: 3, name: "Pasta", imageUrl: nil),restaurant(id: 4, name: "Rice", imageUrl: nil),restaurant(id: 5, name: "Main Dishes", imageUrl: nil),restaurant(id: 6, name: "Main Dishes", imageUrl: nil)]
    
    @State var selectedcategory:restaurant?
    
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
            
            VStack{
                HStack{
                    Image(.categoriesIcon)
                    
                    ScrollViewRTL(type:.hList){
                        HStack(spacing:12){
                            ForEach(categories,id: \.self){category in
                                Button(action: {
                                    selectedcategory = category
                                }, label: {
                                    HStack(spacing:0){
                                        Text(category.name ?? "")
                                            .foregroundColor(selectedcategory == category ? .main2 : .black70)
                                            .font(Font.Regular(size: 12))
                                        
                                        if !(category.imageUrl == nil){
                                            KFImageLoader(urlStr: category.imageUrl, placeholder: Image("2"))
                                                .frame(width: 20, height: 20, alignment: .center)
                                        }
                                    }
                                })
                            }
                        }
                    }
                    .frame(height: 40)
                }
                
                if let category = selectedcategory{
                    HStack(alignment:.center,spacing:0){
                    Text(category.name ?? "")
                        .font(Font.SemiBold(size: 14))
                        .foregroundStyle(.main1)
                    
                        if !(category.imageUrl == nil){
                            KFImageLoader(urlStr: category.imageUrl, placeholder: Image("2"))
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        Spacer()
                    }
                    .padding(.bottom,5)
                }
            }
            .padding(.horizontal)
            .padding(.top,-25)
            
            List{
                ForEach(0..<10){_ in
                    menueListCell(onClick: {
                        isSheetPresented.toggle()
                    },onPlus: { price in
                        basketitemscount += 1
                        basketitemsprice += price
                    },onMinus: {price in
                        basketitemscount -= 1
                        basketitemsprice -= price
                    })
                }
            }
            .listStyle(.plain)
            //                        .padding(.horizontal)
            
            //            Spacer()
            
            VStack(alignment: .center) {
                customDivider()
                    .padding(.bottom)
                    .padding(.horizontal,-20)
                Group{
                    if basketitemscount == 0{
                        Text("Add SAR 1.00 to start your order".localized())
                            .foregroundColor(.wrong)
                            .font(Font.Regular(size: 12))
                    }
                    
                    Button(action: {
                        //                    guard count > 0 else {return}
                        //                    count -= 1
                    }, label: {
                        HStack {
                            Text(basketitemscount,format: .number)
                            
                                .font(.custom(fontEnum.semiBold.rawValue, size:12))
                                .foregroundColor(basketitemscount == 0 ? .white:.main2)
                                .frame(width:33,height: 33)
                                .background{(basketitemscount == 0 ? Color.black25:.white).borderRadius(.clear, cornerRadius: 10, corners: .allCorners)
                                }
                            
                            Text("View basket".localized())
                            Spacer()
                            
                            Text("SAR".localized())
                            Text(basketitemsprice,format: .number)
                        }
                        .font(.custom(fontEnum.semiBold.rawValue, size:12))
                        .foregroundColor(basketitemscount == 0 ? .black50:.white)
                        .padding()
                        
                    })
                    .disabled(basketitemscount == 0)
                    //                .buttonStyle(.plain)
                    .frame(height:50)
                    .background{ (basketitemscount == 0 ? Color.black25:Color.main2).borderRadius(.clear, cornerRadius: 10, corners: .allCorners)
                    }
                    
                }.padding(.horizontal)
            }.padding(.top,-8)
        }
        .padding(.bottom,20)
        .edgesIgnoringSafeArea(.top)
        .background{
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        }
        .bottomSheet(isPresented: $isSheetPresented) {
            menueItemDetails( isPresented: $isSheetPresented)
                .padding(10)
                .padding(.bottom)
                .padding(.bottom,100)
        }
        
    }
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


