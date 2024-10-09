//
//  EXTextfield.swift
//  Hayak
//
//  Created by Mohamed Ragab on 09/10/2024.
//

import SwiftUI


struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField
        
        init(parent: CustomTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.parent.text = textField.text ?? ""
        }
    }
    
    @Binding var text: String
    var placeholder: String
    var placeholderColor: UIColor
    var textColor: UIColor
    var keyboardType : UIKeyboardType
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.textColor = textColor
        textField.keyboardType = keyboardType  // Set the keyboard type to number pad
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.textColor = textColor
        uiView.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

struct CustomSecureTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomSecureTextField
        
        init(parent: CustomSecureTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.parent.text = textField.text ?? ""
        }
    }
    
    @Binding var text: String
    var placeholder: String
    var placeholderColor: UIColor
    var textColor: UIColor
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.isSecureTextEntry = true // Enable secure text entry
        textField.textColor = textColor
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.textColor = textColor
        uiView.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
