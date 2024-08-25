//
//  EditAddressScreen.swift
//  Hayak
//
//  Created by Mohamed Ragab on 29/07/2024.
//

import SwiftUI

struct EditAddressScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showOverlay: Bool = false
    
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "bg1")!).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack {
                CustomHeaderView(title: "Edit Address" , onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                    showOverlay.toggle()
                }, OtherBtnIsfound: true , imageonOtherBtn: "delete", coloronOtherBtn: "main2")
                
                
                ExtractedViewEditAddressScreen()
            }
            
            if showOverlay {
                Color("main1").opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Button("") {
                    }
                    .alert(isPresented: $showOverlay , content: {
                        Alert(title:
                                Text("Do you want to delete this address?"), primaryButton: .default(Text("Yes"), action: {
                            
                        }), secondaryButton: .default(Text("No"),
                                                      action: {
                            
                        })
                        )
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    EditAddressScreen()
}


struct ExtractedViewEditAddressScreen: View {
    
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
                    
                }
                .frame(maxWidth: .infinity , minHeight: 300)
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal , 20)
                
                
                HStack {
                    
                    Text("Set as default address")
                        .font(.custom(fontEnum.medium.rawValue, size: 14))
                        .foregroundColor(Color("main1"))
                    
                    Spacer()
                    
                    Toggle(isOn: $isOn) {
                        
                        
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color("main2")))
                    
                }
                .frame(maxWidth: .infinity , minHeight: 80)
                .padding(.horizontal , 20)
                .background(.white)
                .cornerRadius(20)
                .padding(20)
                
                
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        //Add new address
                        
                    }, label: {
                        Text("Add new address")
                            .frame(height: 50) // Set the height here
                            .frame(maxWidth: .infinity)
                            .font(.custom(fontEnum.medium.rawValue, size: 14))
                            .foregroundColor(Color("empty text field"))
                            .padding(.horizontal , 20)
                            .background(
                                RoundedRectangle(cornerRadius: 0)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5] ))
                                    .foregroundColor(Color("secondary"))
                            )
                            .padding(20)
                    })
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity , minHeight: 100)
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal , 20)
                
                
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
        }
    }
}
