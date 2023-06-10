//
//  Font+Extensions.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 28/12/22.
//

import Foundation
import SwiftUI

extension Font {
    static func regular(size: CGFloat) -> Font {
      return .custom("OpenSans-Regular", size: size)
    }
    
    static func bold(size: CGFloat) -> Font {
      return .custom("OpenSans-Bold", size: size)
    }
    
    static func sourceSemiBold(size: CGFloat) -> Font {
      return .custom("SourceSansPro-SemiBold", size: size)
    }
    
    static func openSemiBold(size: CGFloat) -> Font {
      return .custom("OpenSans-SemiBold", size: size)
    }
}
