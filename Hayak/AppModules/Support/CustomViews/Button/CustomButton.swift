//
//  CustomButton.swift
//  Hayak
//
//  Created by wecancity on 04/09/2024.
//

import SwiftUI

struct CustomButton: View {
//    @State private var language = LocalizationService.shared.language

    var imageName:String?
//    var imageColor:Color?
    var Title = ""
    var bgColor:Color?
    @Binding var IsDisabled:Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
                action()
        }, label: {
            HStack(alignment:.center) {
                if let imageName = imageName{
                    Image(imageName)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20,
                               height: 20, alignment: .center)
//                        .font(Font.system(size: 2))
//                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                if Title.count > 0 {
                    Text(Title.localized())
                        .foregroundStyle(.white)
                        .font(Font.SemiBold(size:14))
//                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)

            .padding()
            .foregroundColor(IsDisabled ?.black50:.white)

            .background((IsDisabled ? Color.black50:.main).borderRadius(.clear, cornerRadius: 8.0, corners: .allCorners)
                
//                RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
//                .fill(IsDisabled ? ColorConstants.Gray300:bgColor ?? ColorConstants.MainColor)
//                .opacity(IsDisabled ? 0.5:1)
            )

            .cornerRadius(8)
        })
            .disabled(IsDisabled)
    }
}

#Preview {
    CustomButton(imageName:"icons8-plus-90",Title: "button",IsDisabled: .constant(false), action:{})
        .frame(width:40,height: 40)
}


struct CustomBorderedButton: View {
    var imageName:String?
    var Title = ""
    @Binding var IsDisabled:Bool
    var action: () -> Void
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            HStack(spacing: 0) {
                if let imageName = imageName{
                    Image(imageName)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20,
                               height: 20, alignment: .center)
//                        .font(Font.system(size: 2))
//                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                Text(Title.localized())
                    .font(Font.SemiBold(size: 14))
                    .fontWeight(.semibold)
//                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(IsDisabled ? .black50:.white)

            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .padding()

//            .overlay(RoundedCorners(topLeft: 8, topRight: 8, bottomLeft: 8,             bottomRight: 8).stroke(IsDisabled ? ColorConstants.Gray300: ColorConstants.MainColor,lineWidth: 2))
            
            .borderRadius(IsDisabled ? .black50:.main,width: 2, cornerRadius: 8, corners: .allCorners)
            
            .background((IsDisabled ? Color.black50:.bg).borderRadius(.clear, cornerRadius: 8.0, corners: .allCorners)
                  
//                        RoundedCorners(topLeft:8,topRight:8,bottomLeft:8,bottomRight:8).fill(ColorConstants.WhiteA700))
                                    
                        
            )
        })
        .disabled(IsDisabled)
        
    }
}
#Preview{
    CustomBorderedButton(IsDisabled: .constant(false), action: {})
}
