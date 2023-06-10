//
//  TextFieldCustomWithTitle.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 29/12/22.
//

import SwiftUI

struct FormCustom<Label: View>: View  {
    let title: String
    var label: () -> Label
    
    
    init(title: String, @ViewBuilder label: @escaping () -> Label) {
        self.title = title
        self.label = label
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 7) {
            Text(title.uppercased())
                .font(.openSemiBold(size: 10))
                .foregroundColor(.black.opacity(0.56))
            label()
                .frame(height: 56)
                .background {
                    Color.whiteCustom
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                }
        }
    }
}

struct FormCustom_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            FormCustom(title: "nombre") {
                TextFieldCustom(textFieldValue: .constant(""), placeholder: "placeholder", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
            }
            FormCustom(title: "apellidos") {
                TextFieldCustom(textFieldValue: .constant("hola"), placeholder: "placeholder", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.marine.opacity(0.02))
    }
}
