//
//  ModelState.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 10/1/23.
//

import Foundation

enum StateListProduct {
    case idle
    case loading
    case loaded([ProductBO])
    case error(String)
}
