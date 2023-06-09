//
//  ProductDTO.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 10/1/23.
//

import Foundation

struct ProductDTO: Decodable {
    
    var title: String?
    var type: String?
    var description: String?
    var filename: String?
    var height: Int?
    var width: Int?
    var price: Double?
    var rating: Int?

}
