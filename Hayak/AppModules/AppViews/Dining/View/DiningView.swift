//
//  DiningView.swift
//  Hayak
//
//  Created by Mohamed Ragab on 22/07/2024.
//

import SwiftUI

struct DiningView: View {
        @Environment(\.dismiss) var dismiss
    @State var startScanning = false
//    @State private var scannedCode: String?
    
    @State var isActive : Bool = false
    @State var destination : AnyView = AnyView(EmptyView())

    var body: some View {
        ZStack (alignment: .top){
            Color(.white).ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            VStack{
                CustomHeaderView(title: "QR Code Scan", onBack: {
                    // Handle back button action
                    print("Back button pressed")
                    //                    presentationMode.wrappedValue.dismiss()
                }, onOtherBtn: {
                }, OtherBtnIsfound: false , imageonOtherBtn: "", coloronOtherBtn: "")
                
                Image(.scanMeQrCode)
                    .padding(.top)
                
                
                VStack(spacing:15){
                    Text("Scan QR Code".localized())
                        .foregroundStyle(.main1)
                        .font(Font.Bold(size: 18))
                    
                    Text("Thank you for choosing our\n service and trusted to help you\n with your problems".localized())
                        .foregroundStyle(.main1)
                        .font(Font.Regular(size: 14))
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,20)
                .background(Color.white.borderRadius(.clear, cornerRadius: 12, corners: .allCorners))
                .padding(.horizontal)
                Spacer()
                
                CustomButton(Title:"Find Currier",IsDisabled:.constant(false) , action: {
                    startScanning = true
                    
                })
                .frame(height: 50)
                .padding(.top,40)
                .padding()
                .padding(.bottom,40)

            }
            .background(.bg)

            NavigationLink( destination: destination,isActive: $isActive,label: {})
        }
        .sheet(isPresented: $startScanning, content: {
            ZStack (alignment: .top){
                QRCodeScannerView (didFindCode:{ scannedCode in
                    startScanning = false
                    //                    self.scannedCode = scannedCode
                    performAction(for: scannedCode)
                })
                scannerTopBar()
            }
        })
        
    }
    
    func performAction(for code: String) {
        // Implement the specific action based on the scanned QR code data
        print("Performing action for: \(code)")
        
        destination = AnyView( MenueView().navigationBarBackButtonHidden(true) )
        isActive = true

    }
    
    func scannerTopBar() -> some View {
        
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .frame(width: 35)

            Spacer()
            Text("Scan QR Code".localized())
                .foregroundStyle(.main1)
                .font(Font.Bold(size: 18))
                .multilineTextAlignment(.center)
          
            Spacer()
            
            Spacer()
                .frame(width: 35)
            
        }.padding()
    }
}

#Preview {
    DiningView()
}
