//
//  PickUpCheckoutView.swift
//  Hayak
//
//  Created by wecancity on 08/09/2024.
//

import SwiftUI

struct PickUpCheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    //    @ObservedObject var localizeHelper = LocalizeHelper.shared // Observe the language changes
    @EnvironmentObject var checkoutvm : CheckoutVM

    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Cart" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
//                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                ExtractedViewCartScreen(checkoutvm: checkoutvm)
            }
            
            .showHud(isShowing: $checkoutvm.isLoading)
            .showAlert(hasAlert: $checkoutvm.isError, alertType: checkoutvm.error)

        }
        
        //        .localizeView()
        //
        //        .onAppear {
        //            LocalizeHelper.shared.setLanguage(language: .english_us)
        //        }
        // Set the environment for layout direction based on the current language
        //        .environment(\.layoutDirection, localizeHelper.currentLanguage == "ar" ? .rightToLeft : .leftToRight)
        
        // in (on Appear / Button) to set lang .. LocalizeHelper.shared.setLanguage(language: .english_us)
        
        
    }
}

#Preview {
    PickUpCheckoutView().environmentObject(CheckoutVM.shared)
}



struct ExtractedViewCartScreen : View {
    
     var checkoutvm : CheckoutVM

    var body: some View {
        
        ScrollView {
            VStack( alignment : .leading , spacing : 20) {
                HStack {
                    Image("cartfill")
                        .foregroundColor(Color("main1"))
                        .frame(width: 50 , height: 50)
                    
                    Text("In your cart")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.bold.rawValue, size: 14))
                    Spacer()
                    
                    Text("\(checkoutvm.checkout?.cartItems?.count ?? 0)")
                        .padding()
                        .frame(minWidth: 50)
                        .frame(height: 50)
                        .foregroundColor(Color("main1"))
                        .background(.bg1).cornerRadius(8)
                        .font(.custom(fontEnum.bold.rawValue, size: 14))
                }
                .frame(height: 60)
                
                //                List {
                ForEach(checkoutvm.checkout?.cartItems ?? []) { attributes in
                    CheckoutCellView( cartItems: attributes)
                }
                //                    .onDelete(perform: deleteItem)
                //                }
              
                VStack (alignment : .leading , spacing : 10) {
                    Text("Special request")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.bold.rawValue, size:16))
                    
                    HStack {
                        Image("note")
                            .frame(width: 25 , height: 25)
                            .offset(y : -10)
                        
                        VStack (alignment : .leading ) {
                            Text("Add a note")
                                .foregroundColor(Color("main1"))
                                .font(.custom(fontEnum.medium.rawValue, size:14))
                            Spacer()
                            Text("Anything else we need to know ?")
                                .foregroundColor(Color("main1"))
                                .font(.custom(fontEnum.medium.rawValue, size:12))
                        }
                    }
                }
                .padding(.bottom , 15)
                
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            
            // views
            VStack(alignment : .leading , spacing: 10) {
                
                Text("Payment summary")
                    .foregroundColor(Color("main1"))
                    .font(.custom(fontEnum.bold.rawValue, size:16))
                
                HStack {
                    Text("Subtotal")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.regular.rawValue, size:12))
                    Spacer()
                    Text("SAR \(checkoutvm.checkout?.subTotal ?? 0)")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:12))
                }
                
                
                HStack {
                    Text("Service fee")
                        .foregroundColor(Color("main2"))
                        .font(.custom(fontEnum.regular.rawValue, size:12))
                    Spacer()
                    Text("SAR \(checkoutvm.checkout?.tax ?? 0)")
                        .foregroundColor(Color("main2"))
                        .font(.custom(fontEnum.medium.rawValue, size:12))
                }
                HStack {
                    Text("Total amount")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:14))
                    Spacer()
                    Text("SAR \(checkoutvm.checkout?.totalPrice ?? 0)")
                        .foregroundColor(Color("main1"))
                        .font(.custom(fontEnum.medium.rawValue, size:14))
                }
                
                Button(action: {
                    checkoutvm.ConfirmCheckout()
                }, label: {
                    Text("Check Out")
                        .frame(height: 50) // Set the height here
                        .frame(maxWidth: .infinity)
                        .font(.custom(fontEnum.medium.rawValue, size: 14))
                        .foregroundColor(Color("bg1")).background(Color("main2"))
                        .cornerRadius(10)
                        .padding(.top , 30)
                })
            }
            .padding(.horizontal , 10)
            
            
            Spacer()
                .frame(height: 50)

        }
        .onAppear {
            if checkoutvm.isCheckoutConfirmed {
                
            }
        }

    }
    
    
    
    // Function to delete item
    private func deleteItem(at offsets: IndexSet) {
        if let index = offsets.first {
            print("Deleting item at index: \(index)") // Print or use the index as needed
            checkoutvm.DeleteFromCart(customerCartId: checkoutvm.checkout?.cartItems?[index].itemID ?? 0 )
        }
        
        if checkoutvm.isCartDeleted {
            SuccessItemdeleted(at: offsets)
        }
    }
    
    private func SuccessItemdeleted(at offsets: IndexSet) {
        checkoutvm.checkout?.cartItems?.remove(atOffsets: offsets)
    }
    
}
