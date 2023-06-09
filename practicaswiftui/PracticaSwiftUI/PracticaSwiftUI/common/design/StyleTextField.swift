//
//  StyleTextField.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 28/12/22.
//

import Foundation
import SwiftUI

struct StyleTextField: ViewModifier {
    @Binding var texFieldValue: String
    var placeholder: String
    var colorPlaceholder: Color
    var colorText: Color
    
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .textFieldStyle(.plain)
            .font(.custom("OpenSans-Regular", size: 16))
            .foregroundColor(colorText)
            .overlay(
                Text(placeholder)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .foregroundColor(colorPlaceholder)
                    .opacity(texFieldValue.isEmpty ? 1 : 0)
                    .allowsHitTesting(false)
            )
    }
}
