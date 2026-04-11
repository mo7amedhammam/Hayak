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



struct BottomSheetView1<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        ZStack{
            Color.black.opacity(0.05)
                .edgesIgnoringSafeArea(.vertical)
//                .borderRadius(.white, cornerRadius: 12, corners: [.topLeft,.topRight])
                .clearSheetBackground() // 🔥 Remove default sheet background
                .onTapGesture {
                    isPresented = false
                }
            VStack(spacing:0) {
                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        isPresented = false
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                            .foregroundColor(.gray)
//                    }
//                    .padding()
//                }
//                .background(.white)
//                .borderRadius(.white, cornerRadius: 12, corners: [.topLeft,.topRight])
                
                content // 🔥 Injected custom content
                //            Spacer()
                    .borderRadius(.white, cornerRadius: 12, corners: [.topLeft,.topRight])

            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            //        .background(Color.black.opacity(0.2))
//            .cornerRadius(15)
            //        .background(BlurView(style: .systemThinMaterial)) // 🔥 Background blur
//            .clearSheetBackground() // 🔥 Remove default sheet background
            //        .background(Color.black.opacity(0.03))
            .edgesIgnoringSafeArea(.vertical)
            
        }
    }
}


//    ---- clearSheetBackground ----
extension View {
    func clearSheetBackground() -> some View {
        self.background(
            UIKitBackgroundClearView()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct UIKitBackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor.black.withAlphaComponent(0.03) // 🔥 Removes default white background
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// ---- BlurView ----
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
