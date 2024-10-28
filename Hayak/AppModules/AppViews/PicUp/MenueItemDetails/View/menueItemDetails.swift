//
//  menueItemDetails.swift
//  Hayak
//
//  Created by wecancity on 03/09/2024.
//

import SwiftUI

struct menueItemDetails: View {
    
    @State var count = 1
    @Binding var isPresented:Bool
    
    @StateObject var itemdetailsvm = ItemDetailsVM()
    @EnvironmentObject var checkoutvm : CheckoutVM

    var iscustomizable : Bool? = true
    var branchId : Int?
    var itemId : Int?
    var body: some View {

        VStack(spacing:15){
            let cart = itemdetailsvm.Details?.customerCart ?? .init()
            ZStack(alignment: .topTrailing) {
                KFImageLoader(urlStr: cart.imageURL, placeholder: Image(.re))
                    .placeholder.resizable()

//                    .resizable()
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
                Text(cart.itemName ?? "")
                    .foregroundColor(.main1)
                    .font(.custom(fontEnum.bold.rawValue, size:18))
                Spacer()
                
                HStack(spacing:3){
                    Text(cart.calories ?? 0,format: .number)
                    Text("Calories".localized())
                }
                .foregroundColor(.main2)
                .font(.custom(fontEnum.semiBold.rawValue, size:12))
                
            }
            Text(cart.description ?? "")
                .foregroundColor(.main2)
                .font(.custom(fontEnum.regular.rawValue, size:14))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack(spacing:3){
                Text("SAR".localized())
                Text(cart.price ?? 0,format: .number.precision(.fractionLength(2)))
            }
            .foregroundColor(.main2)
            .font(.custom(fontEnum.semiBold.rawValue, size:12))
            .frame(maxWidth: .infinity,alignment: .leading)
            
            if iscustomizable == true{
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
                        guard itemdetailsvm.quantity > 0 else {return}
                        itemdetailsvm.quantity -= 1
                    }, label: {
                        Image(systemName: "minus")
                            .font(Font.system(size: 12))
                            .frame(width: 23, height: 23, alignment: .center)
                            .foregroundColor(.main1)
                            .background(.main2.opacity(0.3))
                            .clipShape(Circle())
                    })
                    .buttonStyle(.plain)
                    
                    Text(itemdetailsvm.quantity,format: .number)
                        .foregroundStyle(.main1)
                        .font(.custom(fontEnum.bold.rawValue, size:12))
                        .frame(maxWidth: .infinity,alignment: .center)
                    
                    Button(action: {
                        itemdetailsvm.quantity += 1
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
                    // call add to cart
                    itemdetailsvm.AddToCart()
                }, label: {
                    HStack {
                        Text("Add".localized())
                        Spacer()
                        
                        Text("SAR".localized())
                        Text(itemdetailsvm.quantity*(cart.price ?? 0),format: .number.precision(.fractionLength(2)))
                        
                    }
                    .font(.custom(fontEnum.regular.rawValue, size:14))
                    .foregroundColor(.white)
                    .padding()
                    
                })
                //                .buttonStyle(.plain)
                .frame(height:50)
                .background{ Color.main2.borderRadius(.clear, cornerRadius: 12, corners: .allCorners)
                }
            }
            .padding(.horizontal , 10)
        }
        .task {
            guard let itemId = itemId else {return}
            itemdetailsvm.GetItemDetails(itemId: itemId)
            itemdetailsvm.branchId = branchId
        }
        .task(id: itemdetailsvm.isAddedToCheckout){
            guard itemdetailsvm.isAddedToCheckout == true else{return}
            checkoutvm.GetCheckout()
        }
        .showHud(isShowing: $itemdetailsvm.isLoading)
        .showAlert(hasAlert: $itemdetailsvm.isError, alertType: itemdetailsvm.error)

    }
}

#Preview {
    menueItemDetails( isPresented: .constant(true),itemId: 5).environmentObject(CheckoutVM.shared)
}
