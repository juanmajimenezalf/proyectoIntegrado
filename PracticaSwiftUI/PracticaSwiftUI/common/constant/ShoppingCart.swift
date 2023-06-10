//
//  Carrito.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 16/1/23.
//

import Foundation

final class ShoppingCart: ObservableObject {
    struct ShoppingBasket: Identifiable {
        var id: String { product.title }
        
        var amount: Int
        var product: ProductBO
    }
    
    @Published var shoppingCart: [ShoppingBasket] = []
    @Published var total: Double = 0
    
    func getAmount(product: ProductBO) -> Int {
        guard let shoppingBascket = shoppingCart.first(where: { $0.product.title == product.title }) else { return 0 }
        return shoppingBascket.amount
    }
    
    func incrementAmount(product: ProductBO) {
        if getAmount(product: product) > 0 {
            guard let i = shoppingCart.firstIndex(where: { $0.product.title == product.title }) else { return }
            shoppingCart[i].amount += 1
        } else {
            addProduct(product: product)
        }
        total += product.price
     }
    
    private func addProduct(product: ProductBO) {
        shoppingCart.append(ShoppingBasket.init(amount: 1, product: product))
    }
    
    func decrementAmount(product: ProductBO) {
        guard let i = shoppingCart.firstIndex(where: { $0.product.title == product.title }) else { return }
        shoppingCart[i].amount -= 1
        if getAmount(product: product) <= 0 {
           deleteProduct(product: product)
        }
        total -= product.price
    }
    
    func deleteProduct(product: ProductBO) {
        guard let i = shoppingCart.firstIndex(where: { $0.product.title == product.title }) else { return }
        shoppingCart.remove(at: i)
    }
}
