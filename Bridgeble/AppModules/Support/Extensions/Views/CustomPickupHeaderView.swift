//
//  CustomPickupHeaderView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 09/10/2024.
//

import SwiftUI

struct CustomPickupHeaderView: View {
    @Environment(\.dismiss) var dismiss
    var title: String?
    var subtitle: String?
    
    var btnbackimg : Image? = Image(systemName:"arrow.left")
    var onBack: () -> Void?
    
    var btnimg2 :  (any View)?
    var onbtnimg2: () -> Void?
    
    var btnimg3 : Image?
    var onbtnimg3: () -> Void?
    
    var btnimg4 : Image?
    var onbtnimg4: () -> Void?
    var bgColor:Color? = .white
    
    var body: some View {
        ZStack {
            // Background color or any other customization
            bgColor
                .edgesIgnoringSafeArea(.top)
                .frame(height: 60)
            
            // Content of the header
            HStack(spacing:5) {
                // Back button
                Button(action: {
                    dismiss()
                    onBack()
                }) {
                    if let img = btnbackimg{
                        //                        btnbackimg ??  Image(systemName: "arrow.left")
                        img
                            .font(.custom("LamaSans-Bold", size: 15))
                            .foregroundColor(Color("main1"))
                            .frame(width: 44) // The same width as the back button
                    }
                }
                //                .frame(width: 44) // The same width as the back button
                
                //                Spacer()
                
                // Title
                VStack {
                    Text(title?.localized() ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color("empty text field"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(subtitle?.localized() ?? "")
                        .font(.headline)
                        .foregroundColor(Color("main1"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                if let btnimg2 = btnimg2 {
                    Button(action: {
                        onbtnimg2()
                    }) {
                        AnyView(btnimg2)
                    }
                    .frame(width: 44) // The same width as the back button
                }
                if let btnimg3 = btnimg3{
                    Button(action: {
                        onbtnimg3()
                    }) {
                        btnimg3
                    }
                    .frame(width: 44) // The same width as the back button
                }
                
                if let btnimg4 = btnimg4 {
                    Button(action: {
                        onbtnimg4()
                    }) {
                        btnimg4
                    }
                    .frame(width: 44) // The same width as the back button
                }
                
                
            }
            //            .padding([.leading, .trailing])
            
        }
    }
}

#Preview{
    CustomPickupHeaderView(title: "Title", subtitle: "Subtitle", onBack: {}, btnimg2:AnyView( Image("shopping-icon") ), onbtnimg2: {}, btnimg3: Image("55"), onbtnimg3: {}, btnimg4: Image("carbon_search"), onbtnimg4: {})
}
