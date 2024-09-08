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
    var bgColor:Color? = .main
    var fgColor:Color? = .white
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
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                if Title.count > 0 {
                    Text(Title.localized())
                        .foregroundStyle(fgColor ?? .white)
                        .font(Font.SemiBold(size:14))
                        .multilineTextAlignment(.center)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .padding()
            .foregroundColor(IsDisabled ?.black50:fgColor)
            .background((IsDisabled ? Color.black50:bgColor).borderRadius(.clear, cornerRadius: 8.0, corners: .allCorners)
            )

            .cornerRadius(8)
        })
            .disabled(IsDisabled)
    }
}

#Preview {
    CustomButton(Title: "button",IsDisabled: .constant(false), action:{})
        .frame(width:100,height: 50)
}


struct CustomBorderedButton: View {
    var imageName:String?
    var Title = ""
    var bgColor:Color? = .white
    var fgColor:Color? = .main2

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
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                Text(Title.localized())
                    .foregroundStyle(fgColor ?? .white)
                    .font(Font.SemiBold(size: 14))
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(IsDisabled ? .black50:bgColor)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .padding()
            .borderRadius(IsDisabled ? .black50:fgColor ?? .main,width: 2, cornerRadius: 8, corners: .allCorners)
            
            .background((IsDisabled ? Color.black50:bgColor).borderRadius(.clear, cornerRadius: 8.0, corners: .allCorners)
            )
        })
        .disabled(IsDisabled)
        
    }
}
#Preview{
    CustomBorderedButton(IsDisabled: .constant(false), action: {})
        .frame(width:100,height: 50)

}
