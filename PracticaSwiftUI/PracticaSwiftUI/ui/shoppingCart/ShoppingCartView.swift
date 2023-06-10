//
//  CarritoView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 18/1/23.
//

import SwiftUI

struct ShoppingCartView: View {
    @EnvironmentObject var shoppingCart: ShoppingCart
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State var showAlertCheckout: Bool = false
    var stateShoppingCart: StateShoppingCart {
        if shoppingCart.shoppingCart.isEmpty {
            return .vacio
        } else {
            return .lleno
        }
    }
    
    var body: some View {
        VStack {
            NavigationBarCustom {
                Text("Carrito")
                    .font(.bold(size: 20))
                    .foregroundColor(.whiteCustom)
            }
                    content
               
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.marine.opacity(0.05))
        .background(Color.whiteCustom)
        .background(alert)
    }
    
    @ViewBuilder
    var content: some View {
        switch stateShoppingCart {
        case .vacio:
            VStack {
                Text("El carrito esta vacío")
                    .font(.regular(size: 16))
                    .foregroundColor(.black.opacity(0.5))
                Button("Añadir productos al carrito") {
                    appEnvironment.selectionTab = .listado
                }
                .buttonStyle(StyleCustomButton())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .lleno:
            List {
                ForEach(shoppingCart.shoppingCart) { basket in
                    ShoppingCartCellView(basket: basket)
                        .listRowSeparator(.hidden)
                        .environmentObject(shoppingCart)
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .colorScheme(.light)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Button(String(format: "Pagar %.2f €", shoppingCart.total)) {
                    showAlertCheckout = true
                }
                .buttonStyle(StyleCustomButton())
                .padding(.bottom, 20)
            }
        }
    }
    
    @ViewBuilder
    var alert: some View {
        EmptyView()
            .alert("Compra realiza", isPresented: $showAlertCheckout) {
                Button("Ok", role: .cancel) {
                    withAnimation {
                        for cesta in shoppingCart.shoppingCart {
                            shoppingCart.deleteProduct(product: cesta.product)
                        }
                    }
                }
            } message: {
                Text("Gracias por realizar la compra")
            }
    }
}

enum StateShoppingCart {
    case vacio
    case lleno
}

struct CarritoView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
            .environmentObject(shoppingCart())
            .environmentObject(AppEnvironment())
    }
    
    static func shoppingCart() -> ShoppingCart {
        let shoppingCart = ShoppingCart()
        for _ in 0..<10 {
            shoppingCart.incrementAmount(product: ProductBO.mock)
        }
        return shoppingCart
    }
}
