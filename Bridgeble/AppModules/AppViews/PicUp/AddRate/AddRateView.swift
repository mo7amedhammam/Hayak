//
//  AddRateView.swift
//  Hayak
//
//  Created by wecancity on 08/09/2024.
//

import SwiftUI

struct AddRateView: View {
    
    @State var comment = ""
    @State var rate = 0
    var body: some View {

        VStack{
            HStack{
                Spacer()
                Button(action: {

                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .padding()
//                        .background(Color.black.opacity(0.2))
//                        .clipShape(Circle())
                }.frame(width: 35)
            }.padding()

            ScrollView{
                Image(.LOGO)
                    .frame(width: 252 , height: 122)
                
                Text("What did you like?".localized())
                    .foregroundStyle(.main2)
                    .font(Font.SemiBold(size: 18))
                
                RatingStars(rate: $rate, starWidth: 32)
                    .padding(.vertical)
                    .padding(.bottom)

                MultilineTextField("Add a note...", text: $comment, onCommit: {
                })
                    .font(Font.SemiBold(size:15))
                    .foregroundColor(.main1)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .frame(minHeight: 126)
                    .borderRadius(.black25, cornerRadius: 8, corners: .allCorners)
            }
            .padding(.horizontal)
            
            CustomButton(Title:"Submit",IsDisabled: .constant(false), action: {
                
            })
            .padding(.horizontal)
            .frame(height: 50) // Set the height here
            
        }
    }
}

#Preview {
    AddRateView()
}

struct RatingStars: View {
    @Binding var rate : Int
    var starWidth : CGFloat
    var body: some View {
        HStack(spacing:20){
            ForEach(0..<5){ num in
                Button(action: {
                    rate = num+1
                }, label: {
                    Image(systemName: rate>num ? "star.fill":"star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: starWidth, height: starWidth, alignment: .center)
                        .foregroundColor(.yellow)
                })
            }
        }
    }
}
