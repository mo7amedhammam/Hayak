//
//  TextInputViews.swift
//  Hayak
//
//  Created by wecancity on 08/09/2024.
//

import UIKit
import SwiftUI
struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?

    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) { newValue in
            self.text = newValue
            self.updatePlaceholderVisibility()
        }
    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false
    private var maxHeight: CGFloat = 100

    init (_ placeholder: String = "", text: Binding<String>, maxHeight: CGFloat = 100, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self.maxHeight = maxHeight
        self._showingPlaceholder = State(initialValue: text.wrappedValue.isEmpty)
    }

    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $dynamicHeight, maxHeight: maxHeight, onDone: onCommit)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .background(placeholderView, alignment: .topLeading)
            .onAppear {
                self.updatePlaceholderVisibility()
            }
    }

    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                    Text(placeholder.localized())
                        .foregroundColor(.gray)
                        .padding(.leading, 4)
                        .padding(.top, 8)
            }
        }
    }

    private func updatePlaceholderVisibility() {
        self.showingPlaceholder = self.text.isEmpty
    }
}
fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var maxHeight: CGFloat
    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator

        textView.isEditable = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = true
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.backgroundColor = UIColor.clear
        if nil != onDone {
            textView.returnKeyType = .done
        }

        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight, maxHeight: maxHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>, maxHeight: CGFloat) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        let newHeight = min(newSize.height, maxHeight)
        if result.wrappedValue != newHeight {
            DispatchQueue.main.async {
                result.wrappedValue = newHeight // Must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight, maxHeight: uiView.frame.size.height)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }
}

