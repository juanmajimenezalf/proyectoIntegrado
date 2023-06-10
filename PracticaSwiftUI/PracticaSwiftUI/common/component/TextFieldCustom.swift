//
//  TextFieldCustom.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 28/12/22.
//

import Foundation
import SwiftUI

struct TextFieldCustom: View {
    @Binding var textFieldValue: String
    var placeholder: String
    var color: Color
    var colorPlaceholder: Color
    var colorText: Color
    
    var body: some View {
        color
            .frame(height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .overlay(
                TextField("", text: $textFieldValue)
                    .modifier(StyleTextField(texFieldValue: $textFieldValue, placeholder: placeholder, colorPlaceholder: colorPlaceholder, colorText: colorText))
                    .padding(.horizontal, 15)
                )
    }
}

struct TextFieldCustom_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFieldCustom(textFieldValue: .constant(""), placeholder: "placeholder", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.58), colorText: .whiteCustom)
            TextFieldCustom(textFieldValue: .constant("hola"), placeholder: "placeholder", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.58), colorText: .whiteCustom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.marine)
    }
}
