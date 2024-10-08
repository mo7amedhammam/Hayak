//
//  AddAddressScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 29/07/2024.
//

import SwiftUI

struct AddAddressScreen: View {
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Add Address" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
//                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                    
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                
                ExtractedViewAddAddressScreen()
            }
            
        }

    }
}

#Preview {
    AddAddressScreen()
}


struct ExtractedViewAddAddressScreen: View {
    
    @State private var isChecked: Bool = false
 
    @State private var isOn: Bool = false

    @State var phoneNumber: String = ""

    
    @State private var textLableName: String = "Full Name"
    @State private var textLableNameTitle: String = ""
    @State private var textNamePlaceholder: String = "Enter your full name"
    @State private var imageName: String               = "user"


    @State private var textLableAddresses: String = "Address"
    @State private var textLableAddressesTitle: String = ""
    @State private var textAddressesPlaceholder: String = "Enter your address"
    @State private var imageAddresses: String               = "location"
    

    var body: some View {
        ScrollView {
            VStack (spacing : 0){
                
                VStack {
                    
                    CustomTextfieldView(textLable: $textLableName , text: $textLableNameTitle , title: $textNamePlaceholder, image: $imageName)

                    PhoneNumberView(phoneNumber: $phoneNumber)
                    CustomTextfieldView(textLable: $textLableAddresses , text: $textLableAddressesTitle , title: $textAddressesPlaceholder, image: $imageAddresses)
                    
                    Spacer()

                    
                    Button(action: {
                        //save
                        
                    }, label: {
                        Text("Save")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("bg1")).background(Color("main2"))
                            .cornerRadius(11)
                            .padding(.horizontal , 20)
                    })
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity , minHeight: 420)
                .background(.white)
                .cornerRadius(20)
                .padding( 20)
                
            }
        }
    }
}
