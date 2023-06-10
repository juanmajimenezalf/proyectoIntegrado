//
//  ProductBO.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 10/1/23.
//

import Foundation

struct ProductBO {
    var title: String
    var type: TypeP
    var description: String
    var imageURL: URL
    var height: Int
    var width: Int
    var price: Double
    var rating: Int
}

extension ProductBO: Identifiable {
    var id: String { title }
}

extension ProductBO: Hashable { }

extension ProductBO {
    enum TypeP: String {
        case arma
        case armadura
        case vestuario
        case accesorio
    }
}

extension ProductBO {
    init?(dto: ProductDTO) {
        guard let title = dto.title,
              let type = TypeP(rawValue: dto.type ?? ""),
              let description = dto.description,
              let filename = dto.filename,
              let imageURL = URL(string: "https://raw.githubusercontent.com/juanmajimenezalf/JSON-Sample/main/Products/images/\(filename)"),
              let height = dto.height,
              let width = dto.width,
              let price = dto.price,
              let rating = dto.rating else {
            return nil
        }
        self.title = title
        self.type = type
        self.description = description
        self.imageURL = imageURL
        self.height = height
        self.width = width
        self.price = price
        self.rating = rating
    }
    
    public static let mock = ProductBO(title: "Bastarda Robin – 113cm", type: .arma, description: "Por un precio asequible, obtén nuestra arma de recreación totalmente segura. Todas las armas de LARP de la Edición Básica están construidas con componentes robustos. El mango está moldeado en una sola pieza y está hecho de un material foam más blando. La cuchilla proviene de nuestra línea «Classic» y está firmemente conectada con el mango a la espada terminada.", imageURL: URL(string: "https://raw.githubusercontent.com/juanmajimenezalf/JSON-Sample/main/Products/images/0.jpg")!, height: 600, width: 400, price: 69.90, rating: 4)
}
