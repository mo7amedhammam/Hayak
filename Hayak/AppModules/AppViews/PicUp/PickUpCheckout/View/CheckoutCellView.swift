//
//  CheckoutCellView.swift
//  Hayak
//
//  Created by wecancity on 28/10/2024.
//

import SwiftUI

//struct CartItem: Identifiable {
//    let id = UUID()
//    // Add more properties as needed (e.g., name, price, etc.)
//}

struct CheckoutCellView: View {
    
    @State var plusMinus  = 0
    @EnvironmentObject var itemdetailsvm : ItemDetailsVM
    @EnvironmentObject var viewModel: CheckoutVM
    var cartItems : CheckoutCartItem
    @State var isEditCustomizableItem : Bool = false

    var body: some View {
        
        HStack(spacing : 10) {
            
            VStack(alignment : .leading , spacing : 10) {
                
                Text(cartItems.itemName ?? "")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:14))
                
                Text("SAR \(cartItems.itemPrice ?? 0)")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:12))
                
                if cartItems.itemAttributeValues?.count != 0 {
                    
                    Text("Your Choice of Sauce".localized())
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.regular.rawValue, size:10))
                    
                    ForEach(cartItems.itemAttributeValues ?? [] ) { att in
                        Text(att.attributeValueName ?? "")
                            .foregroundColor(Color("main1"))
                            .font(.custom(fontEnum.bold.rawValue, size:10))
                    }
                }
                Spacer()
                
            }
            Spacer()
            
            VStack (spacing : -10){
                //                KFImageLoader(urlStr: cartItems., placeholder: Image("pickupbgtest"))
                //                    .placeholder.resizable().scaledToFill()
                //                    .resizable()
                //                    .frame(width: 100 , height: 100)
                Image("od")
                    .resizable()
                    .frame(width: 100 , height: 100)
                HStack {
                    Image(systemName: "plus")
                        .frame(width: 20 , height: 20 )
                        .foregroundColor(.white)
                        .onTapGesture {
                            guard cartItems.isCustomizable == false else {
                                isEditCustomizableItem = true
                                return
                            }
                            plusMinus += 1
                            itemdetailsvm.quantity = plusMinus
                            itemdetailsvm.branchId = cartItems.brandBranchId
                            guard let itemid = cartItems.id else {return}
                            itemdetailsvm.Details?.customerCart?.id = itemid
                            viewModel.updateItemQuantity(itemID: itemid , newQuantity: plusMinus)
                            itemdetailsvm.AddToCart()
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
                            guard cartItems.isCustomizable == false else {
                                isEditCustomizableItem = true
                                return
                            }
                            if plusMinus > 1 {
                                plusMinus -= 1
                                itemdetailsvm.quantity = plusMinus
                                itemdetailsvm.branchId = cartItems.brandBranchId
                                guard let itemid = cartItems.id else {return}
                                itemdetailsvm.Details?.customerCart?.id = itemid
                                viewModel.updateItemQuantity(itemID: itemid, newQuantity: plusMinus)
                                itemdetailsvm.AddToCart()
                            }
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
        .frame(minHeight: 120)
        
        .onAppear{
            plusMinus = cartItems.qty ?? 0
        }
        
        //        .bottomSheet(isPresented: $checkoutvm.isEditCustomizableItem){
        .sheet(isPresented: $isEditCustomizableItem, onDismiss: {
            
        }){
             let itemid = cartItems.id
            menueItemDetails( isPresented: $isEditCustomizableItem,
                              itemId: itemid)
        .environmentObject(viewModel)
        .padding(10)
//        .padding(.bottom)
//        .padding(.bottom,100)
        }
        
    }
}

#Preview {
    CheckoutCellView( cartItems: CheckoutCartItem(id: 0, customerCartID: 0, itemPrice: 0, itemName: "name", customerID: 0, qty: 0, itemAttributeValues: [], isCustomizable: false))
        .environmentObject(CheckoutVM.shared)
}
