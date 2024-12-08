//
//  MenueView.swift
//  Hayak
//
//  Created by wecancity on 01/09/2024.
//

import SwiftUI

struct MenueView: View {
    var SelectedBranchId:Int
    @StateObject var menuvm = MenueVM.shared
    @EnvironmentObject var locationManager : LocationManagerVM
    @StateObject var checkoutvm = CheckoutVM.shared

    @State var isSheetPresented = false
//    @State var basketitemscount:Float = 0
//    @State var basketitemsprice:Float = 0
   
    @State var selecteditemId : Int = 0
    @State var isActive : Bool = false
    @State var destination : AnyView = AnyView(EmptyView())
             
    var body: some View {
        VStack {
            ZStack(alignment: .top){
                Image(.re)
                    .resizable()
                    .frame(height: 195)
                
                CustomPickupHeaderView(btnbackimg: Image(.circleback), onBack: {}, btnimg2:Image(.circlelove), onbtnimg2: {
                    
                    // add to favourit
//                    checkoutvm.AddToFavourit(brandBranchId: menuvm.BrandBrancheDetails?.id ?? 0)
                    
                    
                }, btnimg3: Image(.circleshare), onbtnimg3: {}, btnimg4: Image(.circlesearch), onbtnimg4: {},bgColor: .clear)
                    .padding(.top,UIDevice().hasNotch ? 50:20)
            }
            let details = menuvm.BrandBrancheDetails
            VStack(spacing:15){
                HStack{
                    KFImageLoader(urlStr: details?.brandBranchImage, placeholder: Image("od"))
                        .placeholder.resizable()
                        .frame(width: 72,height: 65).scaledToFill().cornerRadius(8)
                    
                    VStack(alignment:.leading,spacing: 7.5){
                        Text(details?.brandBranchName ?? "")
                            .foregroundColor(.black)
                            .font(.custom(fontEnum.bold.rawValue, size:14))
                        
                        Text(details?.description ?? "")
                            .foregroundColor(.black50)
                            .font(.custom(fontEnum.bold.rawValue, size:10))
                        
                        HStack(spacing:2){
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            
                            Text(details?.rate ?? 0,format:.number.precision(.fractionLength(1)))
                                .foregroundColor(.black)
                                .font(.custom(fontEnum.light.rawValue, size:12))
                            
                            Group {
                                Text("(".localized())
                                Text(details?.rateCount ?? 0,format: .number)
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
                    infoLabel(title: "Distance",number: "\(details?.distance ?? 0.0)",measureunit: "KM")
                    infoLabel(title: "cooking time",number: "\(details?.cookingTaime ?? 0)",measureunit: "mins")
//                    hayakRecommendLabel(title: "Recommended by")
                }
            }
            .padding()
            .background(.white)
            .borderRadius(.black25,width: 1.2, cornerRadius: 12, corners: .allCorners)
            .padding()
            .offset(y:-95)
            .padding(.bottom,-95)
            
            if let Categories = menuvm.Categories,Categories.count > 0{
            VStack(alignment: .leading){
                    HStack{
                        Image(.categoriesIcon)
                            .onTapGesture {
                                // show categories drop list
                            }
                        ScrollView{
                            HStack(spacing:12){
                                ForEach(Categories,id: \.self){category in
                                    Button(action: {
                                        menuvm.selectedCategory = category
                                    }, label: {
                                        HStack(spacing:0){
                                            Text(category.name ?? "")
                                                .foregroundColor(menuvm.selectedCategory == category ? .main2 : .black70)
                                                .font(Font.Regular(size: 12))
                                            
                                            if let imageURL = category.imageURL{
                                                KFImageLoader(urlStr: imageURL, placeholder: Image("2"))
                                                    .frame(width: 20, height: 20, alignment: .center)
                                            }
                                        }
                                    })
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(height: 40)
                  
                if let category = menuvm.selectedCategory{
                    HStack(alignment:.center,spacing:0){
                    Text(category.name ?? "")
                        .font(Font.SemiBold(size: 14))
                        .foregroundStyle(.main1)
                    
                        if let imageURL = category.imageURL{
                            KFImageLoader(urlStr: imageURL, placeholder: Image("2"))
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        Spacer()
                    }
                    .padding(.bottom,5)
                }
            }
            .padding(.horizontal)
            .padding(.top,-25)
            }else{
                Spacer()
            }
            
            List(details?.items ?? [],id:\.self){menuitem in
//                ForEach(details?.items ?? [],id:\.self){menuitem in
                    menueListCell(model: menuitem,onClick: {
//                        guard let self = self else {return}
                        selecteditemId = menuitem.id ?? 0
                        isSheetPresented.toggle()
                    }
//                                  ,onPlus: { price in
//                        basketitemscount += 1
//                        basketitemsprice += price
//                    },onMinus: {price in
//                        basketitemscount -= 1
//                        basketitemsprice -= price
//                    }
                    )
//                }
            }
            .listStyle(.plain)
            //                        .padding(.horizontal)
            
            //            Spacer()
            
            VStack(alignment: .center) {
                customDivider()
                    .padding(.bottom)
                    .padding(.horizontal,-20)
                Group{
                    if checkoutvm.checkout?.cartItems?.count ?? 0 == 0 {
                        Text("Add SAR 1.00 to start your order".localized())
                            .foregroundColor(.wrong)
                            .font(Font.Regular(size: 12))
                    }
                    
                    Button(action: {
                        //                    guard count > 0 else {return}
                        //                    count -= 1
                        isActive = true
                        destination = AnyView(PickUpCheckoutView()
                            .environmentObject(checkoutvm)
                            .environmentObject(ItemDetailsVM.shared)
                        )
                    }, label: {
                        HStack {
                            Text(checkoutvm.checkout?.cartItems?.count ?? 0,format: .number)
                                .font(.custom(fontEnum.semiBold.rawValue, size:12))
                                .foregroundColor(checkoutvm.checkout?.cartItems?.count ?? 0 == 0 ? .white:.main2)
                                .frame(width:33,height: 33)
                                .background{(checkoutvm.checkout?.cartItems?.count ?? 0 == 0 ? Color.black25:.white).borderRadius(.clear, cornerRadius: 10, corners: .allCorners)
                                }
                            
                            Text("View basket".localized())
                            Spacer()
                            
                            Text("SAR".localized())
                            Text(checkoutvm.checkout?.totalPrice ?? 0,format: .number.precision(.fractionLength(2)))
                        }
                        .font(.custom(fontEnum.semiBold.rawValue, size:12))
                        .foregroundColor(checkoutvm.checkout?.cartItems?.count ?? 0 == 0 ? .black50:.white)
                        .padding()
                        
                    })
                    .disabled(checkoutvm.checkout?.cartItems?.count ?? 0 == 0)
                    //                .buttonStyle(.plain)
                    .frame(height:50)
                    .background{ (checkoutvm.checkout?.cartItems?.count ?? 0 == 0 ? Color.black25:Color.main2).borderRadius(.clear, cornerRadius: 10, corners: .allCorners)
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
        .task {
            menuvm.lat = locationManager.Currentlat
            menuvm.lon = locationManager.Currentlong

            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                   await menuvm.GetCategoriesForList()
                }
                group.addTask {
                    await menuvm.GetBrandBrancheDetails(id: SelectedBranchId)
                }
                group.addTask {
                    await checkoutvm.GetCheckout()
                }

            }
        }
        .showHud(isShowing: $menuvm.isLoading)
        .showAlert(hasAlert: $menuvm.isError, alertType: menuvm.error)
        
//        .showHud(isShowing: $checkoutvm.isLoading)
//        .showAlert(hasAlert: $checkoutvm.isError, alertType: checkoutvm.error)

        .bottomSheet(isPresented: $isSheetPresented) {
            menueItemDetails( isPresented: $isSheetPresented, branchId:SelectedBranchId, itemId: selecteditemId)
                .environmentObject(checkoutvm)
                .padding(10)
                .padding(.bottom)
                .padding(.bottom,100)
        }
        NavigationLink(
            destination: destination,
            isActive: $isActive,
            label: {EmptyView()})
        
    }
}

#Preview {
    MenueView(SelectedBranchId: 0)
        .environmentObject(LocationManagerVM.shared)
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
                Text("\(number ?? "")")
                Text(measureunit?.localized() ?? "")
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


//--------
//
//  MenueView.swift
//  Hayak
//
//  Created by wecancity on 01/09/2024.
//

//import SwiftUI

//struct MenueView1: View {
//    var SelectedBranchId:Int
//    @StateObject var menuvm = MenueVM.shared
//    @EnvironmentObject var locationManager : LocationManagerVM
//    @StateObject var checkoutvm = CheckoutVM.shared
//
//    @State var isSheetPresented = false
//    @State var basketitemscount:Float = 0
//    @State var basketitemsprice:Float = 0
//   
//    @State var isActive : Bool = false
//    @State var destination : AnyView = AnyView(EmptyView())
//
//    var body: some View {
//        VStack {
//            ZStack(alignment: .top){
//                Image(.re)
//                    .resizable()
//                    .frame(height: 195)
//                
//                CustomPickupHeaderView(btnbackimg: Image(.circleback), onBack: {}, btnimg2:Image(.circlelove), onbtnimg2: {}, btnimg3: Image(.circleshare), onbtnimg3: {}, btnimg4: Image(.circlesearch), onbtnimg4: {},bgColor: .clear)
//                    .padding(.top,UIDevice().hasNotch ? 50:20)
//            }
//            let details = menuvm.BrandBrancheDetails
//            VStack(spacing:15){
//                HStack{
//                    KFImageLoader(urlStr: details?.brandBranchImage, placeholder: Image("od"))
//                        .placeholder.resizable()
//                        .frame(width: 72,height: 65).scaledToFill().cornerRadius(8)
//                    
//                    VStack(alignment:.leading,spacing: 7.5){
//                        Text(details?.brandBranchName ?? "")
//                            .foregroundColor(.black)
//                            .font(.custom(fontEnum.bold.rawValue, size:14))
//                        
//                        Text(details?.description ?? "")
//                            .foregroundColor(.black50)
//                            .font(.custom(fontEnum.bold.rawValue, size:10))
//                        
//                        HStack(spacing:2){
//                            Image(systemName: "star.fill")
//                                .foregroundStyle(.yellow)
//                            
//                            Text(details?.rate ?? 0,format:.number.precision(.fractionLength(1)))
//                                .foregroundColor(.black)
//                                .font(.custom(fontEnum.light.rawValue, size:12))
//                            
//                            Group {
//                                Text("(".localized())
//                                Text(details?.rateCount ?? 0,format: .number)
//                                Text("Ratings".localized())
//                                Text(")".localized())
//                            }
//                            .foregroundColor(.black50)
//                            .font(.custom(fontEnum.regular.rawValue, size:12))
//                        }
//                    }
//                    .frame(maxWidth: .infinity,alignment: .leading)
//                }
//                
//                HStack{
//                    infoLabel(title: "Distance",number: "\(details?.distance ?? 0.0)",measureunit: "KM")
//                    infoLabel(title: "cooking time",number: "\(details?.cookingTaime ?? 0)",measureunit: "mins")
////                    hayakRecommendLabel(title: "Recommended by")
//                }
//            }
//            .padding()
//            .background(.white)
//            .borderRadius(.black25,width: 1.2, cornerRadius: 12, corners: .allCorners)
//            .padding()
//            .offset(y:-95)
//            .padding(.bottom,-95)
//            
//            if let Categories = menuvm.Categories,Categories.count > 0{
//            VStack(alignment: .leading){
//                    HStack{
//                        Image(.categoriesIcon)
//                            .onTapGesture {
//                                // show categories drop list
//                            }
//                        ScrollView{
//                            HStack(spacing:12){
//                                ForEach(Categories,id: \.self){category in
//                                    Button(action: {
//                                        menuvm.selectedCategory = category
//                                    }, label: {
//                                        HStack(spacing:0){
//                                            Text(category.name ?? "")
//                                                .foregroundColor(menuvm.selectedCategory == category ? .main2 : .black70)
//                                                .font(Font.Regular(size: 12))
//                                            
//                                            if let imageURL = category.imageURL{
//                                                KFImageLoader(urlStr: imageURL, placeholder: Image("2"))
//                                                    .frame(width: 20, height: 20, alignment: .center)
//                                            }
//                                        }
//                                    })
//                                }
//                            }
//                        }
//                        Spacer()
//                    }
//                    .frame(height: 40)
//                  
//                if let category = menuvm.selectedCategory{
//                    HStack(alignment:.center,spacing:0){
//                    Text(category.name ?? "")
//                        .font(Font.SemiBold(size: 14))
//                        .foregroundStyle(.main1)
//                    
//                        if let imageURL = category.imageURL{
//                            KFImageLoader(urlStr: imageURL, placeholder: Image("2"))
//                                .frame(width: 20, height: 20, alignment: .center)
//                        }
//                        Spacer()
//                    }
//                    .padding(.bottom,5)
//                }
//            }
//            .padding(.horizontal)
//            .padding(.top,-25)
//            }else{
//                Spacer()
//            }
//            
//            List(details?.items ?? [],id:\.self){menuitem in
////                ForEach(details?.items ?? [],id:\.self){menuitem in
//                    menueListCell(model: menuitem,onClick: {
//                        isSheetPresented.toggle()
//                    }
////                                  ,onPlus: { price in
////                        basketitemscount += 1
////                        basketitemsprice += price
////                    },onMinus: {price in
////                        basketitemscount -= 1
////                        basketitemsprice -= price
////                    }
//                    )
////                }
//            }
//            .listStyle(.plain)
//            //                        .padding(.horizontal)
//            
//            //            Spacer()
//            
//            VStack(alignment: .center) {
//                customDivider()
//                    .padding(.bottom)
//                    .padding(.horizontal,-20)
//                Group{
//                    if checkoutvm.checkout?.cartItems?.count ?? 0 == 0{
//                        Text("Add SAR 1.00 to start your order".localized())
//                            .foregroundColor(.wrong)
//                            .font(Font.Regular(size: 12))
//                    }
//                    
//                    Button(action: {
//                        //                    guard count > 0 else {return}
//                        //                    count -= 1
//
//                        isActive = true
//                        destination = AnyView( PickUpCheckoutView.environmentObject(checkoutvm))
//                    }, label: {
//                        HStack {
//                            Text(checkoutvm.checkout?.totalPrice ?? 0,format: .number)
//                                .font(.custom(fontEnum.semiBold.rawValue, size:12))
//                                .foregroundColor(checkoutvm.checkout.cartItems.count == 0 ? .white:.main2)
//                                .frame(width:33,height: 33)
//                                .background{(basketitemscount == 0 ? Color.black25:.white).borderRadius(.clear, cornerRadius: 10, corners: .allCorners)
//                                }
//                            
//                            Text("View basket".localized())
//                            Spacer()
//                            
//                            Text("SAR".localized())
//                            Text(checkoutvm.checkout?.totalPrice ?? 0,format: .number.precision(.fractionLength(2)))
//                        }
//                        .font(.custom(fontEnum.semiBold.rawValue, size:12))
//                        .foregroundColor(checkoutvm.checkout?.totalPrice ?? 0 == 0 ? .black50:.white)
//                        .padding()
//                        
//                    })
//                    .disabled(checkoutvm.checkout?.cartItems.count ?? 0 == 0)
//                    //                .buttonStyle(.plain)
//                    .frame(height:50)
//                    .background{ (basketitemscount == 0 ? Color.black25:Color.main2).borderRadius(.clear, cornerRadius: 10, corners: .allCorners)
//                    }
//                    
//                }.padding(.horizontal)
//            }.padding(.top,-8)
//        }
//        .padding(.bottom,20)
//        .edgesIgnoringSafeArea(.top)
//        .background{
//            Color(.white).ignoresSafeArea()
//                .navigationBarBackButtonHidden(true)
//        }
//        .task {
//            menuvm.lat = locationManager.Currentlat
//            menuvm.lon = locationManager.Currentlong
//            
//            menuvm.GetCategoriesForList()
//            menuvm.GetBrandBrancheDetails(id: SelectedBranchId)
//        }
//        .bottomSheet(isPresented: $isSheetPresented) {
//            menueItemDetails(isPresented: $isSheetPresented,itemId: 5)
//                .padding(10)
//                .padding(.bottom)
//                .padding(.bottom,100)
//                .environmentObject(checkoutvm)
//        }
//        
//    }
//}

//#Preview {
//    MenueView1(SelectedBranchId: 0)
//        .environmentObject(LocationManagerVM.shared)
//}




