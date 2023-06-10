//
//  TexFieldDescription.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 8/6/23.
//

import SwiftUI

struct TextFieldDescription: View {
    @Binding var textFieldValue: String
    var placeholder: String
    var color: Color
    var colorPlaceholder: Color
    var colorText: Color
    
    var body: some View {
        color
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .overlay(
                TextField("", text: $textFieldValue, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .modifier(StyleTextField(texFieldValue: $textFieldValue, placeholder: placeholder, colorPlaceholder: colorPlaceholder, colorText: colorText))
                    .lineLimit(5...12)
                    .padding([.top, .trailing, .leading])
                )
    }
}

struct TextFieldDescription_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFieldDescription(textFieldValue: .constant(""), placeholder: "placeholder", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.58), colorText: .whiteCustom)
            TextFieldDescription(textFieldValue: .constant("hola"), placeholder: "placeholder", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.58), colorText: .whiteCustom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.marine)
    }
}
