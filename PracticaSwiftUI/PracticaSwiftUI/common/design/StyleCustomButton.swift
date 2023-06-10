//
//  StyleCustomButton.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 27/12/22.
//

import SwiftUI

struct StyleCustomButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            .padding(.horizontal, 34)
            .padding(.vertical, 16)
            .background(configuration.isPressed ? Color("marine") : Color("white"))
            .clipShape(Capsule())
            .foregroundColor(configuration.isPressed ? Color("white") : Color("marine"))
            .overlay(
                Capsule()
                    .stroke(Color("marine"), lineWidth: 2)
            )
    }
    
}

struct StyleCustomButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Test") {
            
        }
        .buttonStyle(StyleCustomButton())
        .previewLayout(.fixed(width: 200, height: 100))
    }
}
