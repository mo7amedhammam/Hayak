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
    
    @StateObject var itemdetailsvm = ItemDetailsVM.shared
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
            
            if iscustomizable == true,let attributes = itemdetailsvm.Details?.addToCartDetails{
                List {
                    ForEach(attributes, id: \.attributeID) { detail in
                        if let attributeName = detail.attributeName {
                            Section(header: HStack {
                                Text(attributeName)
                                    .font(Font.Bold(size: 13))
                                    .foregroundColor(.main1)
                                
                                Spacer()
                                
                                // Add red "Required" text if isRequired is true
                                if detail.isRequired == true {
                                    Text("Required".localized())
                                        .font(.custom(fontEnum.semiBold.rawValue, size:12))
                                        .foregroundColor(.red)
                                    
                                }
                            }
                                .padding()
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .background(.bg1)
                                    
                            ){
                                ForEach(detail.attributeValues ?? [], id: \.itemAttributeValueID) { value in
                                    Button(action: {
                                        handleSelection(for: value.itemAttributeValueID,
                                                        maxValue: detail.maxValue ?? 1,
                                                        attributeID: detail.attributeID)
                                        
                                    }, label: {
                                        HStack(spacing:2) {
                                            let isSelected = itemdetailsvm.extraIds.contains(value.itemAttributeValueID ?? 0)
                                            if isSelected{
                                                Color.main1
                                                    .frame(width:6,height:25)
                                                    .offset(x:-20)
                                            }else{
                                                Color.clear
                                                    .frame(width:6,height:25)
                                                    .offset(x:-20)
                                            }
                                            
                                            Text(value.attributeValueName ?? "Unknown")
                                                .font(Font.Medium(size: 12))
                                                .foregroundColor(.main1)
                                            
                                            if let price = value.attributeValuePrice{
                                                Group{
                                                    Text("(".localized())
                                                    Text("+".localized())
                                                    Text(price,format: .number.precision(.fractionLength(2)))
                                                    Text("SAR".localized())
                                                    Text(")".localized())
                                                }
                                                .font(Font.Medium(size: 12))
                                                .foregroundColor(.main1)
                                            }
                                            Spacer()
                                            
                                            Image((detail.maxValue ?? 1) > 1 ? (isSelected ? "Checkbox-fill" : "Checkbox-empty") : (isSelected ? "RadioButton-fill" : "RadioButton-empty"))
                                                .frame(width:25,height:25)
                                            
                                        }
                                    })
                                }
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(5)
                    
                }
                .listStyle(.plain)
                .padding(.horizontal,-12)
                .padding(.top,-12)
                //                .frame(maxWidth: .infinity,alignment: .center)
                
                
            }
            
            HStack{
                HStack(alignment:.center,spacing:5){
                    
                    Button(action: {
                        guard itemdetailsvm.quantity > 0 else {return}
                        if cart.isCustomizable == false {
                            itemdetailsvm.quantity -= 1
                        }else{
                            // remove customization section
                        }
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
                        if cart.isCustomizable == false{
                        itemdetailsvm.quantity += 1
                        }else{
                            // add customization section
                        }
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
                        Text(Float(itemdetailsvm.quantity)*(cart.price ?? 0),format: .number.precision(.fractionLength(2)))
                        
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
            itemdetailsvm.quantity = 1
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
    
    
    
    private func handleSelection(for itemID: Int?, maxValue: Int, attributeID: Int?) {
        guard let itemID = itemID, let attributeID = attributeID else { return }
        
        // Get current selections for the attribute
        let attributeSelectedIDs = itemdetailsvm.extraIds.filter { selectedID in
            guard let attribute = itemdetailsvm.Details?.addToCartDetails?.first(where: { $0.attributeID == attributeID }),
                  let attributeValues = attribute.attributeValues else { return false }
            return attributeValues.contains { $0.itemAttributeValueID == selectedID }
        }
        
        if maxValue > 1 {
            // Multi-selection case
            if attributeSelectedIDs.contains(itemID) {
                itemdetailsvm.extraIds.removeAll { $0 == itemID }  // Deselect if already selected
            } else if attributeSelectedIDs.count < maxValue {
                itemdetailsvm.extraIds.append(itemID)  // Add if within limit
            }
        } else {
            // Single selection case
            itemdetailsvm.extraIds.removeAll { selectedID in
                guard let attribute = itemdetailsvm.Details?.addToCartDetails?.first(where: { $0.attributeID == attributeID }),
                      let attributeValues = attribute.attributeValues else { return false }
                return attributeValues.contains { $0.itemAttributeValueID == selectedID }
            }
            itemdetailsvm.extraIds.append(itemID)
        }
    }
    
    
}

#Preview {
    menueItemDetails( isPresented: .constant(true),itemId: 5).environmentObject(CheckoutVM.shared)
}
