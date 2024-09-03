//
//  BottomSheet.swift
//  Hayak
//
//  Created by wecancity on 03/09/2024.
//

import SwiftUI

struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let sheetContent: SheetContent
    @State private var sheetHeight: CGFloat = .zero

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> SheetContent) {
        self._isPresented = isPresented
        self.sheetContent = content()
    }

    func body(content: Content) -> some View {
        ZStack (alignment: .top){
            content
            if isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }

                VStack {
                    Spacer()
//                    ZStack(alignment: .top) {
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                withAnimation {
//                                    isPresented = false
//                                }
//                            }) {
//                                Image(systemName: "xmark")
//                                    .foregroundColor(.white)
//                                    .padding(8)
//                                    .background{
//                                        Color.black.clipShape(Circle()).opacity(0.3)
//                                    }
//                            }
//                        }
//                        .frame(height: 40)
//                        .padding(8)
                        sheetContent
//                    }
                        .background(GeometryReader { geometry -> Color in
                            DispatchQueue.main.async {
                                    self.sheetHeight = geometry.size.height
                            }
                            return Color.clear
                        })
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .background(Color.white)
                        .borderRadius(.clear ,cornerRadius: 15, corners: [.topLeft, .topRight])
                        .transition(.move(edge: .bottom))
//                        .transition(.asymmetric(insertion: .move(edge: .bottom),
//                                                removal: .move(edge: .leading)))

                }
                .edgesIgnoringSafeArea(.bottom)
                .animation(.easeInOut, value: isPresented)
            }
        }
    }
}

extension View {
    func bottomSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(BottomSheetModifier(isPresented: isPresented, content: content))
    }
}

