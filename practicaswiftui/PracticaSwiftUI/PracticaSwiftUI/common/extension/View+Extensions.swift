//
//  View.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 28/12/22.
//

import Foundation
import SwiftUI

extension View {
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hideKeyboard() {
        Self.hideKeyboard()
    }
}
