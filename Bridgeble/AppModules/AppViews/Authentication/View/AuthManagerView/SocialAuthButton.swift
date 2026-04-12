//
//  SocialAuthButton.swift
//  Bridgeble
//
//  Created by mohamed hammam on 12/04/2026.
//

import SwiftUI

struct SocialAuthButton: View {
    let title: String
    let icon: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(title.localized())
                    .font(.Medium(size: 16))
                    .foregroundColor(.mainBlue)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(width: 20, height: 20)

            }
            .padding()
//            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.5), lineWidth: 1.5)
            )
        }
    }
}

#Preview {
    SocialAuthButton(
        title: "Continue with Apple_",
        icon: Image(systemName: "applelogo"),
        action: {
            print("Apple tapped")
        }
    )
}
