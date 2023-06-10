//
//  SecureFieldCustom.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 4/1/23.
//

import SwiftUI

struct SecureFieldCustom: View {
    @Binding var textFieldValue: String
    @State var isSecured: Bool = true
    var placeholder: String
    var color: Color
    var colorPlaceholder: Color
    var colorText: Color
    
    var body: some View {
        color
            .frame(height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .overlay {
                HStack {
                    if isSecured {
                        SecureField("", text: $textFieldValue)
                            .modifier(StyleTextField(texFieldValue: $textFieldValue, placeholder: placeholder, colorPlaceholder: colorPlaceholder, colorText: colorText))
                        .padding(.horizontal, 15)
                    } else {
                        TextField("", text: $textFieldValue)
                            .modifier(StyleTextField(texFieldValue: $textFieldValue, placeholder: placeholder, colorPlaceholder: colorPlaceholder, colorText: colorText))
                        .padding(.horizontal, 15)
                    }
                    Button {
                        isSecured.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye" : "eye.slash")
                            .tint(.whiteCustom.opacity(0.7))
                            .padding(.trailing, 10)
                    }
                }
            }
    }
}

struct SecureFieldCustom_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SecureFieldCustom(textFieldValue: .constant(""), placeholder: "placeholder", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.58), colorText: .whiteCustom)
            SecureFieldCustom(textFieldValue: .constant("gdgdf"), placeholder: "placeholder", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.58), colorText: .whiteCustom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.marine)
    }
}
